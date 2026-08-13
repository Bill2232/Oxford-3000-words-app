// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserStats {
  /// Distinct words with at least one review, ever.
  int get wordsPracticed => throw _privateConstructorUsedError;

  /// Total words in the current vocabulary list.
  int get totalWords => throw _privateConstructorUsedError;

  /// Overall correct-answer rate, 0-100. Null when nothing has been
  /// reviewed yet — there's no meaningful accuracy to show.
  int? get accuracyPercent => throw _privateConstructorUsedError;

  /// Consecutive days (including today, if already active) with at
  /// least one review.
  int get currentStreakDays => throw _privateConstructorUsedError;

  /// Distinct words reviewed today.
  int get todayPracticedCount => throw _privateConstructorUsedError;

  /// Today's target, from [AppConstants.dailyPracticeGoal].
  int get dailyGoal => throw _privateConstructorUsedError;

  /// Words at [MasteryLevel.mastered].
  int get masteredWords => throw _privateConstructorUsedError;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStatsCopyWith<UserStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatsCopyWith<$Res> {
  factory $UserStatsCopyWith(UserStats value, $Res Function(UserStats) then) =
      _$UserStatsCopyWithImpl<$Res, UserStats>;
  @useResult
  $Res call({
    int wordsPracticed,
    int totalWords,
    int? accuracyPercent,
    int currentStreakDays,
    int todayPracticedCount,
    int dailyGoal,
    int masteredWords,
  });
}

/// @nodoc
class _$UserStatsCopyWithImpl<$Res, $Val extends UserStats>
    implements $UserStatsCopyWith<$Res> {
  _$UserStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordsPracticed = null,
    Object? totalWords = null,
    Object? accuracyPercent = freezed,
    Object? currentStreakDays = null,
    Object? todayPracticedCount = null,
    Object? dailyGoal = null,
    Object? masteredWords = null,
  }) {
    return _then(
      _value.copyWith(
            wordsPracticed: null == wordsPracticed
                ? _value.wordsPracticed
                : wordsPracticed // ignore: cast_nullable_to_non_nullable
                      as int,
            totalWords: null == totalWords
                ? _value.totalWords
                : totalWords // ignore: cast_nullable_to_non_nullable
                      as int,
            accuracyPercent: freezed == accuracyPercent
                ? _value.accuracyPercent
                : accuracyPercent // ignore: cast_nullable_to_non_nullable
                      as int?,
            currentStreakDays: null == currentStreakDays
                ? _value.currentStreakDays
                : currentStreakDays // ignore: cast_nullable_to_non_nullable
                      as int,
            todayPracticedCount: null == todayPracticedCount
                ? _value.todayPracticedCount
                : todayPracticedCount // ignore: cast_nullable_to_non_nullable
                      as int,
            dailyGoal: null == dailyGoal
                ? _value.dailyGoal
                : dailyGoal // ignore: cast_nullable_to_non_nullable
                      as int,
            masteredWords: null == masteredWords
                ? _value.masteredWords
                : masteredWords // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserStatsImplCopyWith<$Res>
    implements $UserStatsCopyWith<$Res> {
  factory _$$UserStatsImplCopyWith(
    _$UserStatsImpl value,
    $Res Function(_$UserStatsImpl) then,
  ) = __$$UserStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int wordsPracticed,
    int totalWords,
    int? accuracyPercent,
    int currentStreakDays,
    int todayPracticedCount,
    int dailyGoal,
    int masteredWords,
  });
}

/// @nodoc
class __$$UserStatsImplCopyWithImpl<$Res>
    extends _$UserStatsCopyWithImpl<$Res, _$UserStatsImpl>
    implements _$$UserStatsImplCopyWith<$Res> {
  __$$UserStatsImplCopyWithImpl(
    _$UserStatsImpl _value,
    $Res Function(_$UserStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordsPracticed = null,
    Object? totalWords = null,
    Object? accuracyPercent = freezed,
    Object? currentStreakDays = null,
    Object? todayPracticedCount = null,
    Object? dailyGoal = null,
    Object? masteredWords = null,
  }) {
    return _then(
      _$UserStatsImpl(
        wordsPracticed: null == wordsPracticed
            ? _value.wordsPracticed
            : wordsPracticed // ignore: cast_nullable_to_non_nullable
                  as int,
        totalWords: null == totalWords
            ? _value.totalWords
            : totalWords // ignore: cast_nullable_to_non_nullable
                  as int,
        accuracyPercent: freezed == accuracyPercent
            ? _value.accuracyPercent
            : accuracyPercent // ignore: cast_nullable_to_non_nullable
                  as int?,
        currentStreakDays: null == currentStreakDays
            ? _value.currentStreakDays
            : currentStreakDays // ignore: cast_nullable_to_non_nullable
                  as int,
        todayPracticedCount: null == todayPracticedCount
            ? _value.todayPracticedCount
            : todayPracticedCount // ignore: cast_nullable_to_non_nullable
                  as int,
        dailyGoal: null == dailyGoal
            ? _value.dailyGoal
            : dailyGoal // ignore: cast_nullable_to_non_nullable
                  as int,
        masteredWords: null == masteredWords
            ? _value.masteredWords
            : masteredWords // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$UserStatsImpl extends _UserStats {
  const _$UserStatsImpl({
    required this.wordsPracticed,
    required this.totalWords,
    required this.accuracyPercent,
    required this.currentStreakDays,
    required this.todayPracticedCount,
    required this.dailyGoal,
    required this.masteredWords,
  }) : super._();

  /// Distinct words with at least one review, ever.
  @override
  final int wordsPracticed;

  /// Total words in the current vocabulary list.
  @override
  final int totalWords;

  /// Overall correct-answer rate, 0-100. Null when nothing has been
  /// reviewed yet — there's no meaningful accuracy to show.
  @override
  final int? accuracyPercent;

  /// Consecutive days (including today, if already active) with at
  /// least one review.
  @override
  final int currentStreakDays;

  /// Distinct words reviewed today.
  @override
  final int todayPracticedCount;

  /// Today's target, from [AppConstants.dailyPracticeGoal].
  @override
  final int dailyGoal;

  /// Words at [MasteryLevel.mastered].
  @override
  final int masteredWords;

  @override
  String toString() {
    return 'UserStats(wordsPracticed: $wordsPracticed, totalWords: $totalWords, accuracyPercent: $accuracyPercent, currentStreakDays: $currentStreakDays, todayPracticedCount: $todayPracticedCount, dailyGoal: $dailyGoal, masteredWords: $masteredWords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatsImpl &&
            (identical(other.wordsPracticed, wordsPracticed) ||
                other.wordsPracticed == wordsPracticed) &&
            (identical(other.totalWords, totalWords) ||
                other.totalWords == totalWords) &&
            (identical(other.accuracyPercent, accuracyPercent) ||
                other.accuracyPercent == accuracyPercent) &&
            (identical(other.currentStreakDays, currentStreakDays) ||
                other.currentStreakDays == currentStreakDays) &&
            (identical(other.todayPracticedCount, todayPracticedCount) ||
                other.todayPracticedCount == todayPracticedCount) &&
            (identical(other.dailyGoal, dailyGoal) ||
                other.dailyGoal == dailyGoal) &&
            (identical(other.masteredWords, masteredWords) ||
                other.masteredWords == masteredWords));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    wordsPracticed,
    totalWords,
    accuracyPercent,
    currentStreakDays,
    todayPracticedCount,
    dailyGoal,
    masteredWords,
  );

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      __$$UserStatsImplCopyWithImpl<_$UserStatsImpl>(this, _$identity);
}

abstract class _UserStats extends UserStats {
  const factory _UserStats({
    required final int wordsPracticed,
    required final int totalWords,
    required final int? accuracyPercent,
    required final int currentStreakDays,
    required final int todayPracticedCount,
    required final int dailyGoal,
    required final int masteredWords,
  }) = _$UserStatsImpl;
  const _UserStats._() : super._();

  /// Distinct words with at least one review, ever.
  @override
  int get wordsPracticed;

  /// Total words in the current vocabulary list.
  @override
  int get totalWords;

  /// Overall correct-answer rate, 0-100. Null when nothing has been
  /// reviewed yet — there's no meaningful accuracy to show.
  @override
  int? get accuracyPercent;

  /// Consecutive days (including today, if already active) with at
  /// least one review.
  @override
  int get currentStreakDays;

  /// Distinct words reviewed today.
  @override
  int get todayPracticedCount;

  /// Today's target, from [AppConstants.dailyPracticeGoal].
  @override
  int get dailyGoal;

  /// Words at [MasteryLevel.mastered].
  @override
  int get masteredWords;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
