import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/local/preferences/answer_field_preferences.dart';
import 'answer_field_style.dart';

final answerFieldPreferencesProvider =
    Provider((ref) => AnswerFieldPreferences());

/// Holds the selected answer-field style and persists changes, restoring
/// the saved choice on startup.
class AnswerFieldStyleController extends Notifier<AnswerFieldStyle> {
  @override
  AnswerFieldStyle build() {
    _restore();
    return AnswerFieldStyle.letterBoxes;
  }

  Future<void> _restore() async {
    try {
      final saved =
          await ref.read(answerFieldPreferencesProvider).getSelectedStyle();
      if (saved != null) {
        state = saved;
      }
    } catch (_) {
      // Falls back to the default style already set by build() — a
      // failure to read prefs shouldn't block the app from rendering.
    }
  }

  Future<void> select(AnswerFieldStyle style) async {
    state = style;
    try {
      await ref.read(answerFieldPreferencesProvider).setSelectedStyle(style);
    } catch (_) {
      // Ignored — see above.
    }
  }
}

final answerFieldStyleControllerProvider =
    NotifierProvider<AnswerFieldStyleController, AnswerFieldStyle>(
  AnswerFieldStyleController.new,
);
