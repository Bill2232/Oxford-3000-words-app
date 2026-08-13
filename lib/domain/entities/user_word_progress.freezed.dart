// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_word_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserWordProgress {
  int get wordId => throw _privateConstructorUsedError;
  int get timesReviewed => throw _privateConstructorUsedError;
  int get timesCorrect => throw _privateConstructorUsedError;
  int get timesIncorrect => throw _privateConstructorUsedError;
  int get firstAttemptSuccesses => throw _privateConstructorUsedError;
  int get revealCount => throw _privateConstructorUsedError;
  int get hintCount => throw _privateConstructorUsedError;
  double get masteryScore => throw _privateConstructorUsedError;
  MasteryLevel get masteryLevel => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastReviewedAt => throw _privateConstructorUsedError;
  DateTime? get nextReviewAt => throw _privateConstructorUsedError;

  /// Create a copy of UserWordProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserWordProgressCopyWith<UserWordProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserWordProgressCopyWith<$Res> {
  factory $UserWordProgressCopyWith(
    UserWordProgress value,
    $Res Function(UserWordProgress) then,
  ) = _$UserWordProgressCopyWithImpl<$Res, UserWordProgress>;
  @useResult
  $Res call({
    int wordId,
    int timesReviewed,
    int timesCorrect,
    int timesIncorrect,
    int firstAttemptSuccesses,
    int revealCount,
    int hintCount,
    double masteryScore,
    MasteryLevel masteryLevel,
    DateTime createdAt,
    DateTime? lastReviewedAt,
    DateTime? nextReviewAt,
  });
}

/// @nodoc
class _$UserWordProgressCopyWithImpl<$Res, $Val extends UserWordProgress>
    implements $UserWordProgressCopyWith<$Res> {
  _$UserWordProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserWordProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? timesReviewed = null,
    Object? timesCorrect = null,
    Object? timesIncorrect = null,
    Object? firstAttemptSuccesses = null,
    Object? revealCount = null,
    Object? hintCount = null,
    Object? masteryScore = null,
    Object? masteryLevel = null,
    Object? createdAt = null,
    Object? lastReviewedAt = freezed,
    Object? nextReviewAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            wordId: null == wordId
                ? _value.wordId
                : wordId // ignore: cast_nullable_to_non_nullable
                      as int,
            timesReviewed: null == timesReviewed
                ? _value.timesReviewed
                : timesReviewed // ignore: cast_nullable_to_non_nullable
                      as int,
            timesCorrect: null == timesCorrect
                ? _value.timesCorrect
                : timesCorrect // ignore: cast_nullable_to_non_nullable
                      as int,
            timesIncorrect: null == timesIncorrect
                ? _value.timesIncorrect
                : timesIncorrect // ignore: cast_nullable_to_non_nullable
                      as int,
            firstAttemptSuccesses: null == firstAttemptSuccesses
                ? _value.firstAttemptSuccesses
                : firstAttemptSuccesses // ignore: cast_nullable_to_non_nullable
                      as int,
            revealCount: null == revealCount
                ? _value.revealCount
                : revealCount // ignore: cast_nullable_to_non_nullable
                      as int,
            hintCount: null == hintCount
                ? _value.hintCount
                : hintCount // ignore: cast_nullable_to_non_nullable
                      as int,
            masteryScore: null == masteryScore
                ? _value.masteryScore
                : masteryScore // ignore: cast_nullable_to_non_nullable
                      as double,
            masteryLevel: null == masteryLevel
                ? _value.masteryLevel
                : masteryLevel // ignore: cast_nullable_to_non_nullable
                      as MasteryLevel,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastReviewedAt: freezed == lastReviewedAt
                ? _value.lastReviewedAt
                : lastReviewedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            nextReviewAt: freezed == nextReviewAt
                ? _value.nextReviewAt
                : nextReviewAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserWordProgressImplCopyWith<$Res>
    implements $UserWordProgressCopyWith<$Res> {
  factory _$$UserWordProgressImplCopyWith(
    _$UserWordProgressImpl value,
    $Res Function(_$UserWordProgressImpl) then,
  ) = __$$UserWordProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int wordId,
    int timesReviewed,
    int timesCorrect,
    int timesIncorrect,
    int firstAttemptSuccesses,
    int revealCount,
    int hintCount,
    double masteryScore,
    MasteryLevel masteryLevel,
    DateTime createdAt,
    DateTime? lastReviewedAt,
    DateTime? nextReviewAt,
  });
}

/// @nodoc
class __$$UserWordProgressImplCopyWithImpl<$Res>
    extends _$UserWordProgressCopyWithImpl<$Res, _$UserWordProgressImpl>
    implements _$$UserWordProgressImplCopyWith<$Res> {
  __$$UserWordProgressImplCopyWithImpl(
    _$UserWordProgressImpl _value,
    $Res Function(_$UserWordProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserWordProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? timesReviewed = null,
    Object? timesCorrect = null,
    Object? timesIncorrect = null,
    Object? firstAttemptSuccesses = null,
    Object? revealCount = null,
    Object? hintCount = null,
    Object? masteryScore = null,
    Object? masteryLevel = null,
    Object? createdAt = null,
    Object? lastReviewedAt = freezed,
    Object? nextReviewAt = freezed,
  }) {
    return _then(
      _$UserWordProgressImpl(
        wordId: null == wordId
            ? _value.wordId
            : wordId // ignore: cast_nullable_to_non_nullable
                  as int,
        timesReviewed: null == timesReviewed
            ? _value.timesReviewed
            : timesReviewed // ignore: cast_nullable_to_non_nullable
                  as int,
        timesCorrect: null == timesCorrect
            ? _value.timesCorrect
            : timesCorrect // ignore: cast_nullable_to_non_nullable
                  as int,
        timesIncorrect: null == timesIncorrect
            ? _value.timesIncorrect
            : timesIncorrect // ignore: cast_nullable_to_non_nullable
                  as int,
        firstAttemptSuccesses: null == firstAttemptSuccesses
            ? _value.firstAttemptSuccesses
            : firstAttemptSuccesses // ignore: cast_nullable_to_non_nullable
                  as int,
        revealCount: null == revealCount
            ? _value.revealCount
            : revealCount // ignore: cast_nullable_to_non_nullable
                  as int,
        hintCount: null == hintCount
            ? _value.hintCount
            : hintCount // ignore: cast_nullable_to_non_nullable
                  as int,
        masteryScore: null == masteryScore
            ? _value.masteryScore
            : masteryScore // ignore: cast_nullable_to_non_nullable
                  as double,
        masteryLevel: null == masteryLevel
            ? _value.masteryLevel
            : masteryLevel // ignore: cast_nullable_to_non_nullable
                  as MasteryLevel,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastReviewedAt: freezed == lastReviewedAt
            ? _value.lastReviewedAt
            : lastReviewedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        nextReviewAt: freezed == nextReviewAt
            ? _value.nextReviewAt
            : nextReviewAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$UserWordProgressImpl extends _UserWordProgress {
  const _$UserWordProgressImpl({
    required this.wordId,
    required this.timesReviewed,
    required this.timesCorrect,
    required this.timesIncorrect,
    required this.firstAttemptSuccesses,
    required this.revealCount,
    required this.hintCount,
    required this.masteryScore,
    required this.masteryLevel,
    required this.createdAt,
    this.lastReviewedAt,
    this.nextReviewAt,
  }) : super._();

  @override
  final int wordId;
  @override
  final int timesReviewed;
  @override
  final int timesCorrect;
  @override
  final int timesIncorrect;
  @override
  final int firstAttemptSuccesses;
  @override
  final int revealCount;
  @override
  final int hintCount;
  @override
  final double masteryScore;
  @override
  final MasteryLevel masteryLevel;
  @override
  final DateTime createdAt;
  @override
  final DateTime? lastReviewedAt;
  @override
  final DateTime? nextReviewAt;

  @override
  String toString() {
    return 'UserWordProgress(wordId: $wordId, timesReviewed: $timesReviewed, timesCorrect: $timesCorrect, timesIncorrect: $timesIncorrect, firstAttemptSuccesses: $firstAttemptSuccesses, revealCount: $revealCount, hintCount: $hintCount, masteryScore: $masteryScore, masteryLevel: $masteryLevel, createdAt: $createdAt, lastReviewedAt: $lastReviewedAt, nextReviewAt: $nextReviewAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserWordProgressImpl &&
            (identical(other.wordId, wordId) || other.wordId == wordId) &&
            (identical(other.timesReviewed, timesReviewed) ||
                other.timesReviewed == timesReviewed) &&
            (identical(other.timesCorrect, timesCorrect) ||
                other.timesCorrect == timesCorrect) &&
            (identical(other.timesIncorrect, timesIncorrect) ||
                other.timesIncorrect == timesIncorrect) &&
            (identical(other.firstAttemptSuccesses, firstAttemptSuccesses) ||
                other.firstAttemptSuccesses == firstAttemptSuccesses) &&
            (identical(other.revealCount, revealCount) ||
                other.revealCount == revealCount) &&
            (identical(other.hintCount, hintCount) ||
                other.hintCount == hintCount) &&
            (identical(other.masteryScore, masteryScore) ||
                other.masteryScore == masteryScore) &&
            (identical(other.masteryLevel, masteryLevel) ||
                other.masteryLevel == masteryLevel) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastReviewedAt, lastReviewedAt) ||
                other.lastReviewedAt == lastReviewedAt) &&
            (identical(other.nextReviewAt, nextReviewAt) ||
                other.nextReviewAt == nextReviewAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    wordId,
    timesReviewed,
    timesCorrect,
    timesIncorrect,
    firstAttemptSuccesses,
    revealCount,
    hintCount,
    masteryScore,
    masteryLevel,
    createdAt,
    lastReviewedAt,
    nextReviewAt,
  );

  /// Create a copy of UserWordProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserWordProgressImplCopyWith<_$UserWordProgressImpl> get copyWith =>
      __$$UserWordProgressImplCopyWithImpl<_$UserWordProgressImpl>(
        this,
        _$identity,
      );
}

abstract class _UserWordProgress extends UserWordProgress {
  const factory _UserWordProgress({
    required final int wordId,
    required final int timesReviewed,
    required final int timesCorrect,
    required final int timesIncorrect,
    required final int firstAttemptSuccesses,
    required final int revealCount,
    required final int hintCount,
    required final double masteryScore,
    required final MasteryLevel masteryLevel,
    required final DateTime createdAt,
    final DateTime? lastReviewedAt,
    final DateTime? nextReviewAt,
  }) = _$UserWordProgressImpl;
  const _UserWordProgress._() : super._();

  @override
  int get wordId;
  @override
  int get timesReviewed;
  @override
  int get timesCorrect;
  @override
  int get timesIncorrect;
  @override
  int get firstAttemptSuccesses;
  @override
  int get revealCount;
  @override
  int get hintCount;
  @override
  double get masteryScore;
  @override
  MasteryLevel get masteryLevel;
  @override
  DateTime get createdAt;
  @override
  DateTime? get lastReviewedAt;
  @override
  DateTime? get nextReviewAt;

  /// Create a copy of UserWordProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserWordProgressImplCopyWith<_$UserWordProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
