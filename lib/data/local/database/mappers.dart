import 'package:drift/drift.dart';

import '../../../domain/entities/user_word_progress.dart';
import '../../../domain/entities/word.dart';
import '../../../domain/enums/cefr_level.dart';
import '../../../domain/enums/mastery_level.dart';
import '../../../domain/enums/part_of_speech.dart';
import 'app_database.dart';

/// Converts between Drift row/companion types and storage-agnostic domain
/// entities. Kept in one place so the mapping rules aren't duplicated
/// across repositories.
extension WordRowMapper on WordRow {
  Word toDomain() {
    return Word(
      id: id,
      headword: headword,
      partOfSpeech: PartOfSpeech.fromLabel(partOfSpeech),
      cefrLevel: CefrLevel.fromLabel(cefrLevel),
      definition: definition,
      exampleSentence: exampleSentence,
      phoneticSpelling: phoneticSpelling,
      audioUrl: audioUrl,
      tags: tags.isEmpty ? const [] : tags.split(',').map((e) => e.trim()).toList(),
    );
  }
}

extension WordCompanionMapper on Word {
  WordsCompanion toCompanion() {
    return WordsCompanion.insert(
      headword: headword,
      partOfSpeech: partOfSpeech.label,
      cefrLevel: cefrLevel.label,
      definition: definition,
      exampleSentence: exampleSentence,
      phoneticSpelling: Value(phoneticSpelling),
      audioUrl: Value(audioUrl),
      tags: Value(tags.join(',')),
    );
  }
}

extension UserWordProgressRowMapper on UserWordProgressTableData {
  UserWordProgress toDomain() {
    return UserWordProgress(
      wordId: wordId,
      timesReviewed: timesReviewed,
      timesCorrect: timesCorrect,
      timesIncorrect: timesIncorrect,
      firstAttemptSuccesses: firstAttemptSuccesses,
      revealCount: revealCount,
      hintCount: hintCount,
      masteryScore: masteryScore,
      masteryLevel: MasteryLevel.values.firstWhere(
        (e) => e.name == masteryLevel,
        orElse: () => MasteryLevel.newWord,
      ),
      createdAt: createdAt,
      lastReviewedAt: lastReviewedAt,
      nextReviewAt: nextReviewAt,
      userMastered: userMastered,
      masteredAt: masteredAt,
      lastMasteredReviewAt: lastMasteredReviewAt,
      masteredReviewCount: masteredReviewCount,
      masteredReviewSuccessCount: masteredReviewSuccessCount,
      masteredReviewFailCount: masteredReviewFailCount,
    );
  }
}

extension UserWordProgressCompanionMapper on UserWordProgress {
  UserWordProgressTableCompanion toCompanion() {
    return UserWordProgressTableCompanion.insert(
      wordId: Value(wordId),
      timesReviewed: Value(timesReviewed),
      timesCorrect: Value(timesCorrect),
      timesIncorrect: Value(timesIncorrect),
      firstAttemptSuccesses: Value(firstAttemptSuccesses),
      revealCount: Value(revealCount),
      hintCount: Value(hintCount),
      masteryScore: Value(masteryScore),
      masteryLevel: Value(masteryLevel.name),
      createdAt: Value(createdAt),
      lastReviewedAt: Value(lastReviewedAt),
      nextReviewAt: Value(nextReviewAt),
      userMastered: Value(userMastered),
      masteredAt: Value(masteredAt),
      lastMasteredReviewAt: Value(lastMasteredReviewAt),
      masteredReviewCount: Value(masteredReviewCount),
      masteredReviewSuccessCount: Value(masteredReviewSuccessCount),
      masteredReviewFailCount: Value(masteredReviewFailCount),
    );
  }
}
