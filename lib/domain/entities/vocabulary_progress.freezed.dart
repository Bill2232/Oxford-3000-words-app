// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vocabulary_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$VocabularyProgress {
  int get totalWords => throw _privateConstructorUsedError;
  int get wordsPracticed => throw _privateConstructorUsedError;
  int get totalAttempts => throw _privateConstructorUsedError;
  int get correctAnswers => throw _privateConstructorUsedError;
  int get incorrectAnswers => throw _privateConstructorUsedError;

  /// 0-100. Null when no word has ever had a first attempt recorded.
  int? get firstTryAccuracyPercent => throw _privateConstructorUsedError;

  /// 0-100. Null when nothing has been reviewed yet.
  int? get overallAccuracyPercent => throw _privateConstructorUsedError;
  int get currentStreakDays => throw _privateConstructorUsedError;
  int get wordsMastered => throw _privateConstructorUsedError;
  List<CefrLevelProgress> get levelBreakdown =>
      throw _privateConstructorUsedError;
  List<WeakWord> get weakWords => throw _privateConstructorUsedError;

  /// Create a copy of VocabularyProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VocabularyProgressCopyWith<VocabularyProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VocabularyProgressCopyWith<$Res> {
  factory $VocabularyProgressCopyWith(
    VocabularyProgress value,
    $Res Function(VocabularyProgress) then,
  ) = _$VocabularyProgressCopyWithImpl<$Res, VocabularyProgress>;
  @useResult
  $Res call({
    int totalWords,
    int wordsPracticed,
    int totalAttempts,
    int correctAnswers,
    int incorrectAnswers,
    int? firstTryAccuracyPercent,
    int? overallAccuracyPercent,
    int currentStreakDays,
    int wordsMastered,
    List<CefrLevelProgress> levelBreakdown,
    List<WeakWord> weakWords,
  });
}

/// @nodoc
class _$VocabularyProgressCopyWithImpl<$Res, $Val extends VocabularyProgress>
    implements $VocabularyProgressCopyWith<$Res> {
  _$VocabularyProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VocabularyProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalWords = null,
    Object? wordsPracticed = null,
    Object? totalAttempts = null,
    Object? correctAnswers = null,
    Object? incorrectAnswers = null,
    Object? firstTryAccuracyPercent = freezed,
    Object? overallAccuracyPercent = freezed,
    Object? currentStreakDays = null,
    Object? wordsMastered = null,
    Object? levelBreakdown = null,
    Object? weakWords = null,
  }) {
    return _then(
      _value.copyWith(
            totalWords: null == totalWords
                ? _value.totalWords
                : totalWords // ignore: cast_nullable_to_non_nullable
                      as int,
            wordsPracticed: null == wordsPracticed
                ? _value.wordsPracticed
                : wordsPracticed // ignore: cast_nullable_to_non_nullable
                      as int,
            totalAttempts: null == totalAttempts
                ? _value.totalAttempts
                : totalAttempts // ignore: cast_nullable_to_non_nullable
                      as int,
            correctAnswers: null == correctAnswers
                ? _value.correctAnswers
                : correctAnswers // ignore: cast_nullable_to_non_nullable
                      as int,
            incorrectAnswers: null == incorrectAnswers
                ? _value.incorrectAnswers
                : incorrectAnswers // ignore: cast_nullable_to_non_nullable
                      as int,
            firstTryAccuracyPercent: freezed == firstTryAccuracyPercent
                ? _value.firstTryAccuracyPercent
                : firstTryAccuracyPercent // ignore: cast_nullable_to_non_nullable
                      as int?,
            overallAccuracyPercent: freezed == overallAccuracyPercent
                ? _value.overallAccuracyPercent
                : overallAccuracyPercent // ignore: cast_nullable_to_non_nullable
                      as int?,
            currentStreakDays: null == currentStreakDays
                ? _value.currentStreakDays
                : currentStreakDays // ignore: cast_nullable_to_non_nullable
                      as int,
            wordsMastered: null == wordsMastered
                ? _value.wordsMastered
                : wordsMastered // ignore: cast_nullable_to_non_nullable
                      as int,
            levelBreakdown: null == levelBreakdown
                ? _value.levelBreakdown
                : levelBreakdown // ignore: cast_nullable_to_non_nullable
                      as List<CefrLevelProgress>,
            weakWords: null == weakWords
                ? _value.weakWords
                : weakWords // ignore: cast_nullable_to_non_nullable
                      as List<WeakWord>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VocabularyProgressImplCopyWith<$Res>
    implements $VocabularyProgressCopyWith<$Res> {
  factory _$$VocabularyProgressImplCopyWith(
    _$VocabularyProgressImpl value,
    $Res Function(_$VocabularyProgressImpl) then,
  ) = __$$VocabularyProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalWords,
    int wordsPracticed,
    int totalAttempts,
    int correctAnswers,
    int incorrectAnswers,
    int? firstTryAccuracyPercent,
    int? overallAccuracyPercent,
    int currentStreakDays,
    int wordsMastered,
    List<CefrLevelProgress> levelBreakdown,
    List<WeakWord> weakWords,
  });
}

/// @nodoc
class __$$VocabularyProgressImplCopyWithImpl<$Res>
    extends _$VocabularyProgressCopyWithImpl<$Res, _$VocabularyProgressImpl>
    implements _$$VocabularyProgressImplCopyWith<$Res> {
  __$$VocabularyProgressImplCopyWithImpl(
    _$VocabularyProgressImpl _value,
    $Res Function(_$VocabularyProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VocabularyProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalWords = null,
    Object? wordsPracticed = null,
    Object? totalAttempts = null,
    Object? correctAnswers = null,
    Object? incorrectAnswers = null,
    Object? firstTryAccuracyPercent = freezed,
    Object? overallAccuracyPercent = freezed,
    Object? currentStreakDays = null,
    Object? wordsMastered = null,
    Object? levelBreakdown = null,
    Object? weakWords = null,
  }) {
    return _then(
      _$VocabularyProgressImpl(
        totalWords: null == totalWords
            ? _value.totalWords
            : totalWords // ignore: cast_nullable_to_non_nullable
                  as int,
        wordsPracticed: null == wordsPracticed
            ? _value.wordsPracticed
            : wordsPracticed // ignore: cast_nullable_to_non_nullable
                  as int,
        totalAttempts: null == totalAttempts
            ? _value.totalAttempts
            : totalAttempts // ignore: cast_nullable_to_non_nullable
                  as int,
        correctAnswers: null == correctAnswers
            ? _value.correctAnswers
            : correctAnswers // ignore: cast_nullable_to_non_nullable
                  as int,
        incorrectAnswers: null == incorrectAnswers
            ? _value.incorrectAnswers
            : incorrectAnswers // ignore: cast_nullable_to_non_nullable
                  as int,
        firstTryAccuracyPercent: freezed == firstTryAccuracyPercent
            ? _value.firstTryAccuracyPercent
            : firstTryAccuracyPercent // ignore: cast_nullable_to_non_nullable
                  as int?,
        overallAccuracyPercent: freezed == overallAccuracyPercent
            ? _value.overallAccuracyPercent
            : overallAccuracyPercent // ignore: cast_nullable_to_non_nullable
                  as int?,
        currentStreakDays: null == currentStreakDays
            ? _value.currentStreakDays
            : currentStreakDays // ignore: cast_nullable_to_non_nullable
                  as int,
        wordsMastered: null == wordsMastered
            ? _value.wordsMastered
            : wordsMastered // ignore: cast_nullable_to_non_nullable
                  as int,
        levelBreakdown: null == levelBreakdown
            ? _value._levelBreakdown
            : levelBreakdown // ignore: cast_nullable_to_non_nullable
                  as List<CefrLevelProgress>,
        weakWords: null == weakWords
            ? _value._weakWords
            : weakWords // ignore: cast_nullable_to_non_nullable
                  as List<WeakWord>,
      ),
    );
  }
}

/// @nodoc

class _$VocabularyProgressImpl extends _VocabularyProgress {
  const _$VocabularyProgressImpl({
    required this.totalWords,
    required this.wordsPracticed,
    required this.totalAttempts,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.firstTryAccuracyPercent,
    required this.overallAccuracyPercent,
    required this.currentStreakDays,
    required this.wordsMastered,
    required final List<CefrLevelProgress> levelBreakdown,
    required final List<WeakWord> weakWords,
  }) : _levelBreakdown = levelBreakdown,
       _weakWords = weakWords,
       super._();

  @override
  final int totalWords;
  @override
  final int wordsPracticed;
  @override
  final int totalAttempts;
  @override
  final int correctAnswers;
  @override
  final int incorrectAnswers;

  /// 0-100. Null when no word has ever had a first attempt recorded.
  @override
  final int? firstTryAccuracyPercent;

  /// 0-100. Null when nothing has been reviewed yet.
  @override
  final int? overallAccuracyPercent;
  @override
  final int currentStreakDays;
  @override
  final int wordsMastered;
  final List<CefrLevelProgress> _levelBreakdown;
  @override
  List<CefrLevelProgress> get levelBreakdown {
    if (_levelBreakdown is EqualUnmodifiableListView) return _levelBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_levelBreakdown);
  }

  final List<WeakWord> _weakWords;
  @override
  List<WeakWord> get weakWords {
    if (_weakWords is EqualUnmodifiableListView) return _weakWords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weakWords);
  }

  @override
  String toString() {
    return 'VocabularyProgress(totalWords: $totalWords, wordsPracticed: $wordsPracticed, totalAttempts: $totalAttempts, correctAnswers: $correctAnswers, incorrectAnswers: $incorrectAnswers, firstTryAccuracyPercent: $firstTryAccuracyPercent, overallAccuracyPercent: $overallAccuracyPercent, currentStreakDays: $currentStreakDays, wordsMastered: $wordsMastered, levelBreakdown: $levelBreakdown, weakWords: $weakWords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VocabularyProgressImpl &&
            (identical(other.totalWords, totalWords) ||
                other.totalWords == totalWords) &&
            (identical(other.wordsPracticed, wordsPracticed) ||
                other.wordsPracticed == wordsPracticed) &&
            (identical(other.totalAttempts, totalAttempts) ||
                other.totalAttempts == totalAttempts) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.incorrectAnswers, incorrectAnswers) ||
                other.incorrectAnswers == incorrectAnswers) &&
            (identical(
                  other.firstTryAccuracyPercent,
                  firstTryAccuracyPercent,
                ) ||
                other.firstTryAccuracyPercent == firstTryAccuracyPercent) &&
            (identical(other.overallAccuracyPercent, overallAccuracyPercent) ||
                other.overallAccuracyPercent == overallAccuracyPercent) &&
            (identical(other.currentStreakDays, currentStreakDays) ||
                other.currentStreakDays == currentStreakDays) &&
            (identical(other.wordsMastered, wordsMastered) ||
                other.wordsMastered == wordsMastered) &&
            const DeepCollectionEquality().equals(
              other._levelBreakdown,
              _levelBreakdown,
            ) &&
            const DeepCollectionEquality().equals(
              other._weakWords,
              _weakWords,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalWords,
    wordsPracticed,
    totalAttempts,
    correctAnswers,
    incorrectAnswers,
    firstTryAccuracyPercent,
    overallAccuracyPercent,
    currentStreakDays,
    wordsMastered,
    const DeepCollectionEquality().hash(_levelBreakdown),
    const DeepCollectionEquality().hash(_weakWords),
  );

  /// Create a copy of VocabularyProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VocabularyProgressImplCopyWith<_$VocabularyProgressImpl> get copyWith =>
      __$$VocabularyProgressImplCopyWithImpl<_$VocabularyProgressImpl>(
        this,
        _$identity,
      );
}

abstract class _VocabularyProgress extends VocabularyProgress {
  const factory _VocabularyProgress({
    required final int totalWords,
    required final int wordsPracticed,
    required final int totalAttempts,
    required final int correctAnswers,
    required final int incorrectAnswers,
    required final int? firstTryAccuracyPercent,
    required final int? overallAccuracyPercent,
    required final int currentStreakDays,
    required final int wordsMastered,
    required final List<CefrLevelProgress> levelBreakdown,
    required final List<WeakWord> weakWords,
  }) = _$VocabularyProgressImpl;
  const _VocabularyProgress._() : super._();

  @override
  int get totalWords;
  @override
  int get wordsPracticed;
  @override
  int get totalAttempts;
  @override
  int get correctAnswers;
  @override
  int get incorrectAnswers;

  /// 0-100. Null when no word has ever had a first attempt recorded.
  @override
  int? get firstTryAccuracyPercent;

  /// 0-100. Null when nothing has been reviewed yet.
  @override
  int? get overallAccuracyPercent;
  @override
  int get currentStreakDays;
  @override
  int get wordsMastered;
  @override
  List<CefrLevelProgress> get levelBreakdown;
  @override
  List<WeakWord> get weakWords;

  /// Create a copy of VocabularyProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VocabularyProgressImplCopyWith<_$VocabularyProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
