// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practice_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PracticeState {
  Word get word => throw _privateConstructorUsedError;
  CheckResult get result => throw _privateConstructorUsedError;
  bool get isRevealed => throw _privateConstructorUsedError;
  int get attemptsThisWord => throw _privateConstructorUsedError;
  int get wordsCompletedThisSession => throw _privateConstructorUsedError;
  bool get justMarkedMastered => throw _privateConstructorUsedError;

  /// Create a copy of PracticeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PracticeStateCopyWith<PracticeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PracticeStateCopyWith<$Res> {
  factory $PracticeStateCopyWith(
    PracticeState value,
    $Res Function(PracticeState) then,
  ) = _$PracticeStateCopyWithImpl<$Res, PracticeState>;
  @useResult
  $Res call({
    Word word,
    CheckResult result,
    bool isRevealed,
    int attemptsThisWord,
    int wordsCompletedThisSession,
    bool justMarkedMastered,
  });

  $WordCopyWith<$Res> get word;
}

/// @nodoc
class _$PracticeStateCopyWithImpl<$Res, $Val extends PracticeState>
    implements $PracticeStateCopyWith<$Res> {
  _$PracticeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PracticeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? result = null,
    Object? isRevealed = null,
    Object? attemptsThisWord = null,
    Object? wordsCompletedThisSession = null,
    Object? justMarkedMastered = null,
  }) {
    return _then(
      _value.copyWith(
            word: null == word
                ? _value.word
                : word // ignore: cast_nullable_to_non_nullable
                      as Word,
            result: null == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                      as CheckResult,
            isRevealed: null == isRevealed
                ? _value.isRevealed
                : isRevealed // ignore: cast_nullable_to_non_nullable
                      as bool,
            attemptsThisWord: null == attemptsThisWord
                ? _value.attemptsThisWord
                : attemptsThisWord // ignore: cast_nullable_to_non_nullable
                      as int,
            wordsCompletedThisSession: null == wordsCompletedThisSession
                ? _value.wordsCompletedThisSession
                : wordsCompletedThisSession // ignore: cast_nullable_to_non_nullable
                      as int,
            justMarkedMastered: null == justMarkedMastered
                ? _value.justMarkedMastered
                : justMarkedMastered // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of PracticeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WordCopyWith<$Res> get word {
    return $WordCopyWith<$Res>(_value.word, (value) {
      return _then(_value.copyWith(word: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PracticeStateImplCopyWith<$Res>
    implements $PracticeStateCopyWith<$Res> {
  factory _$$PracticeStateImplCopyWith(
    _$PracticeStateImpl value,
    $Res Function(_$PracticeStateImpl) then,
  ) = __$$PracticeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Word word,
    CheckResult result,
    bool isRevealed,
    int attemptsThisWord,
    int wordsCompletedThisSession,
    bool justMarkedMastered,
  });

  @override
  $WordCopyWith<$Res> get word;
}

/// @nodoc
class __$$PracticeStateImplCopyWithImpl<$Res>
    extends _$PracticeStateCopyWithImpl<$Res, _$PracticeStateImpl>
    implements _$$PracticeStateImplCopyWith<$Res> {
  __$$PracticeStateImplCopyWithImpl(
    _$PracticeStateImpl _value,
    $Res Function(_$PracticeStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PracticeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? result = null,
    Object? isRevealed = null,
    Object? attemptsThisWord = null,
    Object? wordsCompletedThisSession = null,
    Object? justMarkedMastered = null,
  }) {
    return _then(
      _$PracticeStateImpl(
        word: null == word
            ? _value.word
            : word // ignore: cast_nullable_to_non_nullable
                  as Word,
        result: null == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as CheckResult,
        isRevealed: null == isRevealed
            ? _value.isRevealed
            : isRevealed // ignore: cast_nullable_to_non_nullable
                  as bool,
        attemptsThisWord: null == attemptsThisWord
            ? _value.attemptsThisWord
            : attemptsThisWord // ignore: cast_nullable_to_non_nullable
                  as int,
        wordsCompletedThisSession: null == wordsCompletedThisSession
            ? _value.wordsCompletedThisSession
            : wordsCompletedThisSession // ignore: cast_nullable_to_non_nullable
                  as int,
        justMarkedMastered: null == justMarkedMastered
            ? _value.justMarkedMastered
            : justMarkedMastered // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$PracticeStateImpl implements _PracticeState {
  const _$PracticeStateImpl({
    required this.word,
    this.result = CheckResult.none,
    this.isRevealed = false,
    this.attemptsThisWord = 0,
    this.wordsCompletedThisSession = 0,
    this.justMarkedMastered = false,
  });

  @override
  final Word word;
  @override
  @JsonKey()
  final CheckResult result;
  @override
  @JsonKey()
  final bool isRevealed;
  @override
  @JsonKey()
  final int attemptsThisWord;
  @override
  @JsonKey()
  final int wordsCompletedThisSession;
  @override
  @JsonKey()
  final bool justMarkedMastered;

  @override
  String toString() {
    return 'PracticeState(word: $word, result: $result, isRevealed: $isRevealed, attemptsThisWord: $attemptsThisWord, wordsCompletedThisSession: $wordsCompletedThisSession, justMarkedMastered: $justMarkedMastered)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PracticeStateImpl &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.isRevealed, isRevealed) ||
                other.isRevealed == isRevealed) &&
            (identical(other.attemptsThisWord, attemptsThisWord) ||
                other.attemptsThisWord == attemptsThisWord) &&
            (identical(
                  other.wordsCompletedThisSession,
                  wordsCompletedThisSession,
                ) ||
                other.wordsCompletedThisSession == wordsCompletedThisSession) &&
            (identical(other.justMarkedMastered, justMarkedMastered) ||
                other.justMarkedMastered == justMarkedMastered));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    word,
    result,
    isRevealed,
    attemptsThisWord,
    wordsCompletedThisSession,
    justMarkedMastered,
  );

  /// Create a copy of PracticeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PracticeStateImplCopyWith<_$PracticeStateImpl> get copyWith =>
      __$$PracticeStateImplCopyWithImpl<_$PracticeStateImpl>(this, _$identity);
}

abstract class _PracticeState implements PracticeState {
  const factory _PracticeState({
    required final Word word,
    final CheckResult result,
    final bool isRevealed,
    final int attemptsThisWord,
    final int wordsCompletedThisSession,
    final bool justMarkedMastered,
  }) = _$PracticeStateImpl;

  @override
  Word get word;
  @override
  CheckResult get result;
  @override
  bool get isRevealed;
  @override
  int get attemptsThisWord;
  @override
  int get wordsCompletedThisSession;
  @override
  bool get justMarkedMastered;

  /// Create a copy of PracticeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PracticeStateImplCopyWith<_$PracticeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
