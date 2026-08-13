import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../domain/entities/word.dart';
import '../../domain/entities/word_explanation.dart';
import '../utils/result.dart';
import 'explanation_service.dart';

/// Raised for any explanation failure the UI should show a message for —
/// missing configuration, network failure, a non-200 response, a model
/// refusal, or a response that doesn't match the expected shape.
class ExplanationException implements Exception {
  const ExplanationException(this.message);
  final String message;

  @override
  String toString() => message;
}

/// Calls the Claude API directly to generate learner-facing explanations.
///
/// No official Anthropic SDK exists for Dart/Flutter, so this uses the
/// Messages API over plain HTTP with `output_config.format` (structured
/// outputs) to get back exactly the four V1 fields as JSON, rather than
/// parsing free-form prose.
///
/// The API key is read at build time via `--dart-define=ANTHROPIC_API_KEY=…`
/// so it never lives in source control. Note this still ships the key
/// inside the compiled client binary — fine for this foundation/demo, but
/// a production build should route explanation requests through a backend
/// proxy instead of calling Anthropic directly from the app. Swapping that
/// in later only means writing a new [ExplanationService], not touching
/// any screen — that's the point of the abstraction.
class AnthropicExplanationService implements ExplanationService {
  AnthropicExplanationService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _apiKey = String.fromEnvironment('ANTHROPIC_API_KEY');
  static const _endpoint = 'https://api.anthropic.com/v1/messages';
  static const _model = 'claude-opus-5';
  static const _requestTimeout = Duration(seconds: 25);

  final http.Client _httpClient;

  bool get isConfigured => _apiKey.isNotEmpty;

  @override
  Future<Result<WordExplanation>> explain(Word word) async {
    if (!isConfigured) {
      return Result.failure(
        const ExplanationException(
          'AI explanation feature is coming soon...',
        ),
      );
    }

    try {
      final response = await _httpClient
          .post(
            Uri.parse(_endpoint),
            headers: {
              'content-type': 'application/json',
              'x-api-key': _apiKey,
              'anthropic-version': '2023-06-01',
            },
            body: jsonEncode(_buildRequestBody(word)),
          )
          .timeout(_requestTimeout);

      return _parseResponse(response);
    } on TimeoutException {
      return Result.failure(
        const ExplanationException('The explanation took too long to load.'),
      );
    } on SocketException {
      return Result.failure(
        const ExplanationException('No internet connection.'),
      );
    } catch (error, stackTrace) {
      return Result.failure(
        ExplanationException('Could not load an explanation: $error'),
        stackTrace,
      );
    }
  }

  Map<String, dynamic> _buildRequestBody(Word word) {
    return {
      'model': _model,
      'max_tokens': 1024,
      'output_config': {
        'effort': 'low',
        'format': {
          'type': 'json_schema',
          'schema': {
            'type': 'object',
            'properties': {
              'meaning': {
                'type': 'string',
                'description':
                    'A simple, one or two sentence definition a learner at B1 English level can understand.',
              },
              'commonUses': {
                'type': 'array',
                'items': {'type': 'string'},
                'description':
                    '2-3 short phrases showing common, natural ways this word is used (e.g. typical collocations or contexts).',
              },
              'exampleSentence': {
                'type': 'string',
                'description':
                    'One natural, everyday example sentence using the word.',
              },
              'shortStory': {
                'type': 'string',
                'description':
                    'A short (3-5 sentence) simple story that uses the word in context, to help the learner remember it.',
              },
            },
            'required': [
              'meaning',
              'commonUses',
              'exampleSentence',
              'shortStory',
            ],
            'additionalProperties': false,
          },
        },
      },
      'messages': [
        {
          'role': 'user',
          'content':
              'Explain the English word "${word.headword}" '
              '(${word.partOfSpeech.label}, CEFR ${word.cefrLevel.label}) '
              'for an English learner. Existing dictionary definition for '
              'reference: "${word.definition}". Keep all text simple and '
              'easy to understand — short sentences, everyday vocabulary.',
        },
      ],
    };
  }

  Result<WordExplanation> _parseResponse(http.Response response) {
    if (response.statusCode != 200) {
      final message = _extractErrorMessage(response.body) ??
          'The explanation service returned an error (${response.statusCode}).';
      return Result.failure(ExplanationException(message));
    }

    final Map<String, dynamic> body;
    try {
      body = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      return Result.failure(
        const ExplanationException('Received an unreadable response.'),
      );
    }

    if (body['stop_reason'] == 'refusal') {
      return Result.failure(
        const ExplanationException(
          'The explanation was declined. Try a different word.',
        ),
      );
    }

    final content = body['content'] as List<dynamic>?;
    final textBlock = content?.firstWhere(
      (block) => (block as Map<String, dynamic>)['type'] == 'text',
      orElse: () => null,
    ) as Map<String, dynamic>?;
    final text = textBlock?['text'] as String?;

    if (text == null || text.trim().isEmpty) {
      return Result.failure(
        const ExplanationException('Received an empty explanation.'),
      );
    }

    try {
      final parsed = jsonDecode(text) as Map<String, dynamic>;
      final commonUses = (parsed['commonUses'] as List<dynamic>)
          .map((e) => e.toString())
          .toList();

      if ((parsed['meaning'] as String).trim().isEmpty ||
          commonUses.isEmpty ||
          (parsed['exampleSentence'] as String).trim().isEmpty ||
          (parsed['shortStory'] as String).trim().isEmpty) {
        return Result.failure(
          const ExplanationException('Received an incomplete explanation.'),
        );
      }

      return Result.success(
        WordExplanation(
          meaning: parsed['meaning'] as String,
          commonUses: commonUses,
          exampleSentence: parsed['exampleSentence'] as String,
          shortStory: parsed['shortStory'] as String,
        ),
      );
    } catch (_) {
      return Result.failure(
        const ExplanationException('Received a malformed explanation.'),
      );
    }
  }

  String? _extractErrorMessage(String body) {
    try {
      final decoded = jsonDecode(body) as Map<String, dynamic>;
      final error = decoded['error'] as Map<String, dynamic>?;
      return error?['message'] as String?;
    } catch (_) {
      return null;
    }
  }
}
