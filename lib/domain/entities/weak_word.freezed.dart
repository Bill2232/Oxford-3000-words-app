// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weak_word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WeakWord {
  Word get word => throw _privateConstructorUsedError;
  int get timesReviewed => throw _privateConstructorUsedError;
  int get timesIncorrect => throw _privateConstructorUsedError;
  int get accuracyPercent => throw _privateConstructorUsedError;

  /// Create a copy of WeakWord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeakWordCopyWith<WeakWord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeakWordCopyWith<$Res> {
  factory $WeakWordCopyWith(WeakWord value, $Res Function(WeakWord) then) =
      _$WeakWordCopyWithImpl<$Res, WeakWord>;
  @useResult
  $Res call({
    Word word,
    int timesReviewed,
    int timesIncorrect,
    int accuracyPercent,
  });

  $WordCopyWith<$Res> get word;
}

/// @nodoc
class _$WeakWordCopyWithImpl<$Res, $Val extends WeakWord>
    implements $WeakWordCopyWith<$Res> {
  _$WeakWordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeakWord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? timesReviewed = null,
    Object? timesIncorrect = null,
    Object? accuracyPercent = null,
  }) {
    return _then(
      _value.copyWith(
            word: null == word
                ? _value.word
                : word // ignore: cast_nullable_to_non_nullable
                      as Word,
            timesReviewed: null == timesReviewed
                ? _value.timesReviewed
                : timesReviewed // ignore: cast_nullable_to_non_nullable
                      as int,
            timesIncorrect: null == timesIncorrect
                ? _value.timesIncorrect
                : timesIncorrect // ignore: cast_nullable_to_non_nullable
                      as int,
            accuracyPercent: null == accuracyPercent
                ? _value.accuracyPercent
                : accuracyPercent // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of WeakWord
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
abstract class _$$WeakWordImplCopyWith<$Res>
    implements $WeakWordCopyWith<$Res> {
  factory _$$WeakWordImplCopyWith(
    _$WeakWordImpl value,
    $Res Function(_$WeakWordImpl) then,
  ) = __$$WeakWordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Word word,
    int timesReviewed,
    int timesIncorrect,
    int accuracyPercent,
  });

  @override
  $WordCopyWith<$Res> get word;
}

/// @nodoc
class __$$WeakWordImplCopyWithImpl<$Res>
    extends _$WeakWordCopyWithImpl<$Res, _$WeakWordImpl>
    implements _$$WeakWordImplCopyWith<$Res> {
  __$$WeakWordImplCopyWithImpl(
    _$WeakWordImpl _value,
    $Res Function(_$WeakWordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeakWord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? timesReviewed = null,
    Object? timesIncorrect = null,
    Object? accuracyPercent = null,
  }) {
    return _then(
      _$WeakWordImpl(
        word: null == word
            ? _value.word
            : word // ignore: cast_nullable_to_non_nullable
                  as Word,
        timesReviewed: null == timesReviewed
            ? _value.timesReviewed
            : timesReviewed // ignore: cast_nullable_to_non_nullable
                  as int,
        timesIncorrect: null == timesIncorrect
            ? _value.timesIncorrect
            : timesIncorrect // ignore: cast_nullable_to_non_nullable
                  as int,
        accuracyPercent: null == accuracyPercent
            ? _value.accuracyPercent
            : accuracyPercent // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$WeakWordImpl extends _WeakWord {
  const _$WeakWordImpl({
    required this.word,
    required this.timesReviewed,
    required this.timesIncorrect,
    required this.accuracyPercent,
  }) : super._();

  @override
  final Word word;
  @override
  final int timesReviewed;
  @override
  final int timesIncorrect;
  @override
  final int accuracyPercent;

  @override
  String toString() {
    return 'WeakWord(word: $word, timesReviewed: $timesReviewed, timesIncorrect: $timesIncorrect, accuracyPercent: $accuracyPercent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeakWordImpl &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.timesReviewed, timesReviewed) ||
                other.timesReviewed == timesReviewed) &&
            (identical(other.timesIncorrect, timesIncorrect) ||
                other.timesIncorrect == timesIncorrect) &&
            (identical(other.accuracyPercent, accuracyPercent) ||
                other.accuracyPercent == accuracyPercent));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    word,
    timesReviewed,
    timesIncorrect,
    accuracyPercent,
  );

  /// Create a copy of WeakWord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeakWordImplCopyWith<_$WeakWordImpl> get copyWith =>
      __$$WeakWordImplCopyWithImpl<_$WeakWordImpl>(this, _$identity);
}

abstract class _WeakWord extends WeakWord {
  const factory _WeakWord({
    required final Word word,
    required final int timesReviewed,
    required final int timesIncorrect,
    required final int accuracyPercent,
  }) = _$WeakWordImpl;
  const _WeakWord._() : super._();

  @override
  Word get word;
  @override
  int get timesReviewed;
  @override
  int get timesIncorrect;
  @override
  int get accuracyPercent;

  /// Create a copy of WeakWord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeakWordImplCopyWith<_$WeakWordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
