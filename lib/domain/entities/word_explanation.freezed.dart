// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_explanation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WordExplanation {
  String get meaning => throw _privateConstructorUsedError;
  List<String> get commonUses => throw _privateConstructorUsedError;
  String get exampleSentence => throw _privateConstructorUsedError;
  String get shortStory => throw _privateConstructorUsedError;

  /// Create a copy of WordExplanation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WordExplanationCopyWith<WordExplanation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordExplanationCopyWith<$Res> {
  factory $WordExplanationCopyWith(
    WordExplanation value,
    $Res Function(WordExplanation) then,
  ) = _$WordExplanationCopyWithImpl<$Res, WordExplanation>;
  @useResult
  $Res call({
    String meaning,
    List<String> commonUses,
    String exampleSentence,
    String shortStory,
  });
}

/// @nodoc
class _$WordExplanationCopyWithImpl<$Res, $Val extends WordExplanation>
    implements $WordExplanationCopyWith<$Res> {
  _$WordExplanationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WordExplanation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meaning = null,
    Object? commonUses = null,
    Object? exampleSentence = null,
    Object? shortStory = null,
  }) {
    return _then(
      _value.copyWith(
            meaning: null == meaning
                ? _value.meaning
                : meaning // ignore: cast_nullable_to_non_nullable
                      as String,
            commonUses: null == commonUses
                ? _value.commonUses
                : commonUses // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            exampleSentence: null == exampleSentence
                ? _value.exampleSentence
                : exampleSentence // ignore: cast_nullable_to_non_nullable
                      as String,
            shortStory: null == shortStory
                ? _value.shortStory
                : shortStory // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WordExplanationImplCopyWith<$Res>
    implements $WordExplanationCopyWith<$Res> {
  factory _$$WordExplanationImplCopyWith(
    _$WordExplanationImpl value,
    $Res Function(_$WordExplanationImpl) then,
  ) = __$$WordExplanationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String meaning,
    List<String> commonUses,
    String exampleSentence,
    String shortStory,
  });
}

/// @nodoc
class __$$WordExplanationImplCopyWithImpl<$Res>
    extends _$WordExplanationCopyWithImpl<$Res, _$WordExplanationImpl>
    implements _$$WordExplanationImplCopyWith<$Res> {
  __$$WordExplanationImplCopyWithImpl(
    _$WordExplanationImpl _value,
    $Res Function(_$WordExplanationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WordExplanation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meaning = null,
    Object? commonUses = null,
    Object? exampleSentence = null,
    Object? shortStory = null,
  }) {
    return _then(
      _$WordExplanationImpl(
        meaning: null == meaning
            ? _value.meaning
            : meaning // ignore: cast_nullable_to_non_nullable
                  as String,
        commonUses: null == commonUses
            ? _value._commonUses
            : commonUses // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        exampleSentence: null == exampleSentence
            ? _value.exampleSentence
            : exampleSentence // ignore: cast_nullable_to_non_nullable
                  as String,
        shortStory: null == shortStory
            ? _value.shortStory
            : shortStory // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$WordExplanationImpl implements _WordExplanation {
  const _$WordExplanationImpl({
    required this.meaning,
    required final List<String> commonUses,
    required this.exampleSentence,
    required this.shortStory,
  }) : _commonUses = commonUses;

  @override
  final String meaning;
  final List<String> _commonUses;
  @override
  List<String> get commonUses {
    if (_commonUses is EqualUnmodifiableListView) return _commonUses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commonUses);
  }

  @override
  final String exampleSentence;
  @override
  final String shortStory;

  @override
  String toString() {
    return 'WordExplanation(meaning: $meaning, commonUses: $commonUses, exampleSentence: $exampleSentence, shortStory: $shortStory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordExplanationImpl &&
            (identical(other.meaning, meaning) || other.meaning == meaning) &&
            const DeepCollectionEquality().equals(
              other._commonUses,
              _commonUses,
            ) &&
            (identical(other.exampleSentence, exampleSentence) ||
                other.exampleSentence == exampleSentence) &&
            (identical(other.shortStory, shortStory) ||
                other.shortStory == shortStory));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    meaning,
    const DeepCollectionEquality().hash(_commonUses),
    exampleSentence,
    shortStory,
  );

  /// Create a copy of WordExplanation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WordExplanationImplCopyWith<_$WordExplanationImpl> get copyWith =>
      __$$WordExplanationImplCopyWithImpl<_$WordExplanationImpl>(
        this,
        _$identity,
      );
}

abstract class _WordExplanation implements WordExplanation {
  const factory _WordExplanation({
    required final String meaning,
    required final List<String> commonUses,
    required final String exampleSentence,
    required final String shortStory,
  }) = _$WordExplanationImpl;

  @override
  String get meaning;
  @override
  List<String> get commonUses;
  @override
  String get exampleSentence;
  @override
  String get shortStory;

  /// Create a copy of WordExplanation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WordExplanationImplCopyWith<_$WordExplanationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
