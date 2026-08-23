// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastered_word_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MasteredWordEntry {
  Word get word => throw _privateConstructorUsedError;
  MasteryLevel get automaticMasteryLevel => throw _privateConstructorUsedError;
  DateTime? get masteredAt => throw _privateConstructorUsedError;

  /// Create a copy of MasteredWordEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MasteredWordEntryCopyWith<MasteredWordEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MasteredWordEntryCopyWith<$Res> {
  factory $MasteredWordEntryCopyWith(
    MasteredWordEntry value,
    $Res Function(MasteredWordEntry) then,
  ) = _$MasteredWordEntryCopyWithImpl<$Res, MasteredWordEntry>;
  @useResult
  $Res call({
    Word word,
    MasteryLevel automaticMasteryLevel,
    DateTime? masteredAt,
  });

  $WordCopyWith<$Res> get word;
}

/// @nodoc
class _$MasteredWordEntryCopyWithImpl<$Res, $Val extends MasteredWordEntry>
    implements $MasteredWordEntryCopyWith<$Res> {
  _$MasteredWordEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MasteredWordEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? automaticMasteryLevel = null,
    Object? masteredAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            word: null == word
                ? _value.word
                : word // ignore: cast_nullable_to_non_nullable
                      as Word,
            automaticMasteryLevel: null == automaticMasteryLevel
                ? _value.automaticMasteryLevel
                : automaticMasteryLevel // ignore: cast_nullable_to_non_nullable
                      as MasteryLevel,
            masteredAt: freezed == masteredAt
                ? _value.masteredAt
                : masteredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of MasteredWordEntry
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
abstract class _$$MasteredWordEntryImplCopyWith<$Res>
    implements $MasteredWordEntryCopyWith<$Res> {
  factory _$$MasteredWordEntryImplCopyWith(
    _$MasteredWordEntryImpl value,
    $Res Function(_$MasteredWordEntryImpl) then,
  ) = __$$MasteredWordEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Word word,
    MasteryLevel automaticMasteryLevel,
    DateTime? masteredAt,
  });

  @override
  $WordCopyWith<$Res> get word;
}

/// @nodoc
class __$$MasteredWordEntryImplCopyWithImpl<$Res>
    extends _$MasteredWordEntryCopyWithImpl<$Res, _$MasteredWordEntryImpl>
    implements _$$MasteredWordEntryImplCopyWith<$Res> {
  __$$MasteredWordEntryImplCopyWithImpl(
    _$MasteredWordEntryImpl _value,
    $Res Function(_$MasteredWordEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MasteredWordEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? automaticMasteryLevel = null,
    Object? masteredAt = freezed,
  }) {
    return _then(
      _$MasteredWordEntryImpl(
        word: null == word
            ? _value.word
            : word // ignore: cast_nullable_to_non_nullable
                  as Word,
        automaticMasteryLevel: null == automaticMasteryLevel
            ? _value.automaticMasteryLevel
            : automaticMasteryLevel // ignore: cast_nullable_to_non_nullable
                  as MasteryLevel,
        masteredAt: freezed == masteredAt
            ? _value.masteredAt
            : masteredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$MasteredWordEntryImpl implements _MasteredWordEntry {
  const _$MasteredWordEntryImpl({
    required this.word,
    required this.automaticMasteryLevel,
    this.masteredAt,
  });

  @override
  final Word word;
  @override
  final MasteryLevel automaticMasteryLevel;
  @override
  final DateTime? masteredAt;

  @override
  String toString() {
    return 'MasteredWordEntry(word: $word, automaticMasteryLevel: $automaticMasteryLevel, masteredAt: $masteredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MasteredWordEntryImpl &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.automaticMasteryLevel, automaticMasteryLevel) ||
                other.automaticMasteryLevel == automaticMasteryLevel) &&
            (identical(other.masteredAt, masteredAt) ||
                other.masteredAt == masteredAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, word, automaticMasteryLevel, masteredAt);

  /// Create a copy of MasteredWordEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MasteredWordEntryImplCopyWith<_$MasteredWordEntryImpl> get copyWith =>
      __$$MasteredWordEntryImplCopyWithImpl<_$MasteredWordEntryImpl>(
        this,
        _$identity,
      );
}

abstract class _MasteredWordEntry implements MasteredWordEntry {
  const factory _MasteredWordEntry({
    required final Word word,
    required final MasteryLevel automaticMasteryLevel,
    final DateTime? masteredAt,
  }) = _$MasteredWordEntryImpl;

  @override
  Word get word;
  @override
  MasteryLevel get automaticMasteryLevel;
  @override
  DateTime? get masteredAt;

  /// Create a copy of MasteredWordEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MasteredWordEntryImplCopyWith<_$MasteredWordEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
