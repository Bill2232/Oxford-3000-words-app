// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cefr_level_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CefrLevelProgress {
  CefrLevel get level => throw _privateConstructorUsedError;
  int get totalWords => throw _privateConstructorUsedError;
  int get practicedWords => throw _privateConstructorUsedError;
  int get masteredWords => throw _privateConstructorUsedError;
  int? get accuracyPercent => throw _privateConstructorUsedError;

  /// Create a copy of CefrLevelProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CefrLevelProgressCopyWith<CefrLevelProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CefrLevelProgressCopyWith<$Res> {
  factory $CefrLevelProgressCopyWith(
    CefrLevelProgress value,
    $Res Function(CefrLevelProgress) then,
  ) = _$CefrLevelProgressCopyWithImpl<$Res, CefrLevelProgress>;
  @useResult
  $Res call({
    CefrLevel level,
    int totalWords,
    int practicedWords,
    int masteredWords,
    int? accuracyPercent,
  });
}

/// @nodoc
class _$CefrLevelProgressCopyWithImpl<$Res, $Val extends CefrLevelProgress>
    implements $CefrLevelProgressCopyWith<$Res> {
  _$CefrLevelProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CefrLevelProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? totalWords = null,
    Object? practicedWords = null,
    Object? masteredWords = null,
    Object? accuracyPercent = freezed,
  }) {
    return _then(
      _value.copyWith(
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as CefrLevel,
            totalWords: null == totalWords
                ? _value.totalWords
                : totalWords // ignore: cast_nullable_to_non_nullable
                      as int,
            practicedWords: null == practicedWords
                ? _value.practicedWords
                : practicedWords // ignore: cast_nullable_to_non_nullable
                      as int,
            masteredWords: null == masteredWords
                ? _value.masteredWords
                : masteredWords // ignore: cast_nullable_to_non_nullable
                      as int,
            accuracyPercent: freezed == accuracyPercent
                ? _value.accuracyPercent
                : accuracyPercent // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CefrLevelProgressImplCopyWith<$Res>
    implements $CefrLevelProgressCopyWith<$Res> {
  factory _$$CefrLevelProgressImplCopyWith(
    _$CefrLevelProgressImpl value,
    $Res Function(_$CefrLevelProgressImpl) then,
  ) = __$$CefrLevelProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    CefrLevel level,
    int totalWords,
    int practicedWords,
    int masteredWords,
    int? accuracyPercent,
  });
}

/// @nodoc
class __$$CefrLevelProgressImplCopyWithImpl<$Res>
    extends _$CefrLevelProgressCopyWithImpl<$Res, _$CefrLevelProgressImpl>
    implements _$$CefrLevelProgressImplCopyWith<$Res> {
  __$$CefrLevelProgressImplCopyWithImpl(
    _$CefrLevelProgressImpl _value,
    $Res Function(_$CefrLevelProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CefrLevelProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? totalWords = null,
    Object? practicedWords = null,
    Object? masteredWords = null,
    Object? accuracyPercent = freezed,
  }) {
    return _then(
      _$CefrLevelProgressImpl(
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as CefrLevel,
        totalWords: null == totalWords
            ? _value.totalWords
            : totalWords // ignore: cast_nullable_to_non_nullable
                  as int,
        practicedWords: null == practicedWords
            ? _value.practicedWords
            : practicedWords // ignore: cast_nullable_to_non_nullable
                  as int,
        masteredWords: null == masteredWords
            ? _value.masteredWords
            : masteredWords // ignore: cast_nullable_to_non_nullable
                  as int,
        accuracyPercent: freezed == accuracyPercent
            ? _value.accuracyPercent
            : accuracyPercent // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$CefrLevelProgressImpl extends _CefrLevelProgress {
  const _$CefrLevelProgressImpl({
    required this.level,
    required this.totalWords,
    required this.practicedWords,
    required this.masteredWords,
    required this.accuracyPercent,
  }) : super._();

  @override
  final CefrLevel level;
  @override
  final int totalWords;
  @override
  final int practicedWords;
  @override
  final int masteredWords;
  @override
  final int? accuracyPercent;

  @override
  String toString() {
    return 'CefrLevelProgress(level: $level, totalWords: $totalWords, practicedWords: $practicedWords, masteredWords: $masteredWords, accuracyPercent: $accuracyPercent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CefrLevelProgressImpl &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.totalWords, totalWords) ||
                other.totalWords == totalWords) &&
            (identical(other.practicedWords, practicedWords) ||
                other.practicedWords == practicedWords) &&
            (identical(other.masteredWords, masteredWords) ||
                other.masteredWords == masteredWords) &&
            (identical(other.accuracyPercent, accuracyPercent) ||
                other.accuracyPercent == accuracyPercent));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    level,
    totalWords,
    practicedWords,
    masteredWords,
    accuracyPercent,
  );

  /// Create a copy of CefrLevelProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CefrLevelProgressImplCopyWith<_$CefrLevelProgressImpl> get copyWith =>
      __$$CefrLevelProgressImplCopyWithImpl<_$CefrLevelProgressImpl>(
        this,
        _$identity,
      );
}

abstract class _CefrLevelProgress extends CefrLevelProgress {
  const factory _CefrLevelProgress({
    required final CefrLevel level,
    required final int totalWords,
    required final int practicedWords,
    required final int masteredWords,
    required final int? accuracyPercent,
  }) = _$CefrLevelProgressImpl;
  const _CefrLevelProgress._() : super._();

  @override
  CefrLevel get level;
  @override
  int get totalWords;
  @override
  int get practicedWords;
  @override
  int get masteredWords;
  @override
  int? get accuracyPercent;

  /// Create a copy of CefrLevelProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CefrLevelProgressImplCopyWith<_$CefrLevelProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
