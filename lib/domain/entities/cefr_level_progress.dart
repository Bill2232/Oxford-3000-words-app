import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/cefr_level.dart';

part 'cefr_level_progress.freezed.dart';

/// Vocabulary progress within one Oxford 3000 CEFR grouping. This is a
/// coverage/practice summary of the app's own word list, not an official
/// CEFR language assessment.
@freezed
class CefrLevelProgress with _$CefrLevelProgress {
  const CefrLevelProgress._();

  const factory CefrLevelProgress({
    required CefrLevel level,
    required int totalWords,
    required int practicedWords,
    required int masteredWords,
    required int? accuracyPercent,
  }) = _CefrLevelProgress;

  double get practicedFraction =>
      totalWords <= 0 ? 0 : (practicedWords / totalWords).clamp(0, 1);

  double get masteredFraction =>
      totalWords <= 0 ? 0 : (masteredWords / totalWords).clamp(0, 1);

  bool get hasAccuracyData => accuracyPercent != null;
}
