// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Word {
  int get id => throw _privateConstructorUsedError;
  String get headword => throw _privateConstructorUsedError;
  PartOfSpeech get partOfSpeech => throw _privateConstructorUsedError;
  CefrLevel get cefrLevel => throw _privateConstructorUsedError;
  String get definition => throw _privateConstructorUsedError;
  String get exampleSentence => throw _privateConstructorUsedError;
  String? get phoneticSpelling => throw _privateConstructorUsedError;
  String? get audioUrl => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WordCopyWith<Word> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordCopyWith<$Res> {
  factory $WordCopyWith(Word value, $Res Function(Word) then) =
      _$WordCopyWithImpl<$Res, Word>;
  @useResult
  $Res call({
    int id,
    String headword,
    PartOfSpeech partOfSpeech,
    CefrLevel cefrLevel,
    String definition,
    String exampleSentence,
    String? phoneticSpelling,
    String? audioUrl,
    List<String> tags,
  });
}

/// @nodoc
class _$WordCopyWithImpl<$Res, $Val extends Word>
    implements $WordCopyWith<$Res> {
  _$WordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? headword = null,
    Object? partOfSpeech = null,
    Object? cefrLevel = null,
    Object? definition = null,
    Object? exampleSentence = null,
    Object? phoneticSpelling = freezed,
    Object? audioUrl = freezed,
    Object? tags = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            headword: null == headword
                ? _value.headword
                : headword // ignore: cast_nullable_to_non_nullable
                      as String,
            partOfSpeech: null == partOfSpeech
                ? _value.partOfSpeech
                : partOfSpeech // ignore: cast_nullable_to_non_nullable
                      as PartOfSpeech,
            cefrLevel: null == cefrLevel
                ? _value.cefrLevel
                : cefrLevel // ignore: cast_nullable_to_non_nullable
                      as CefrLevel,
            definition: null == definition
                ? _value.definition
                : definition // ignore: cast_nullable_to_non_nullable
                      as String,
            exampleSentence: null == exampleSentence
                ? _value.exampleSentence
                : exampleSentence // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneticSpelling: freezed == phoneticSpelling
                ? _value.phoneticSpelling
                : phoneticSpelling // ignore: cast_nullable_to_non_nullable
                      as String?,
            audioUrl: freezed == audioUrl
                ? _value.audioUrl
                : audioUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WordImplCopyWith<$Res> implements $WordCopyWith<$Res> {
  factory _$$WordImplCopyWith(
    _$WordImpl value,
    $Res Function(_$WordImpl) then,
  ) = __$$WordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String headword,
    PartOfSpeech partOfSpeech,
    CefrLevel cefrLevel,
    String definition,
    String exampleSentence,
    String? phoneticSpelling,
    String? audioUrl,
    List<String> tags,
  });
}

/// @nodoc
class __$$WordImplCopyWithImpl<$Res>
    extends _$WordCopyWithImpl<$Res, _$WordImpl>
    implements _$$WordImplCopyWith<$Res> {
  __$$WordImplCopyWithImpl(_$WordImpl _value, $Res Function(_$WordImpl) _then)
    : super(_value, _then);

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? headword = null,
    Object? partOfSpeech = null,
    Object? cefrLevel = null,
    Object? definition = null,
    Object? exampleSentence = null,
    Object? phoneticSpelling = freezed,
    Object? audioUrl = freezed,
    Object? tags = null,
  }) {
    return _then(
      _$WordImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        headword: null == headword
            ? _value.headword
            : headword // ignore: cast_nullable_to_non_nullable
                  as String,
        partOfSpeech: null == partOfSpeech
            ? _value.partOfSpeech
            : partOfSpeech // ignore: cast_nullable_to_non_nullable
                  as PartOfSpeech,
        cefrLevel: null == cefrLevel
            ? _value.cefrLevel
            : cefrLevel // ignore: cast_nullable_to_non_nullable
                  as CefrLevel,
        definition: null == definition
            ? _value.definition
            : definition // ignore: cast_nullable_to_non_nullable
                  as String,
        exampleSentence: null == exampleSentence
            ? _value.exampleSentence
            : exampleSentence // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneticSpelling: freezed == phoneticSpelling
            ? _value.phoneticSpelling
            : phoneticSpelling // ignore: cast_nullable_to_non_nullable
                  as String?,
        audioUrl: freezed == audioUrl
            ? _value.audioUrl
            : audioUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$WordImpl implements _Word {
  const _$WordImpl({
    required this.id,
    required this.headword,
    required this.partOfSpeech,
    required this.cefrLevel,
    required this.definition,
    required this.exampleSentence,
    this.phoneticSpelling,
    this.audioUrl,
    final List<String> tags = const <String>[],
  }) : _tags = tags;

  @override
  final int id;
  @override
  final String headword;
  @override
  final PartOfSpeech partOfSpeech;
  @override
  final CefrLevel cefrLevel;
  @override
  final String definition;
  @override
  final String exampleSentence;
  @override
  final String? phoneticSpelling;
  @override
  final String? audioUrl;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'Word(id: $id, headword: $headword, partOfSpeech: $partOfSpeech, cefrLevel: $cefrLevel, definition: $definition, exampleSentence: $exampleSentence, phoneticSpelling: $phoneticSpelling, audioUrl: $audioUrl, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.headword, headword) ||
                other.headword == headword) &&
            (identical(other.partOfSpeech, partOfSpeech) ||
                other.partOfSpeech == partOfSpeech) &&
            (identical(other.cefrLevel, cefrLevel) ||
                other.cefrLevel == cefrLevel) &&
            (identical(other.definition, definition) ||
                other.definition == definition) &&
            (identical(other.exampleSentence, exampleSentence) ||
                other.exampleSentence == exampleSentence) &&
            (identical(other.phoneticSpelling, phoneticSpelling) ||
                other.phoneticSpelling == phoneticSpelling) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    headword,
    partOfSpeech,
    cefrLevel,
    definition,
    exampleSentence,
    phoneticSpelling,
    audioUrl,
    const DeepCollectionEquality().hash(_tags),
  );

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WordImplCopyWith<_$WordImpl> get copyWith =>
      __$$WordImplCopyWithImpl<_$WordImpl>(this, _$identity);
}

abstract class _Word implements Word {
  const factory _Word({
    required final int id,
    required final String headword,
    required final PartOfSpeech partOfSpeech,
    required final CefrLevel cefrLevel,
    required final String definition,
    required final String exampleSentence,
    final String? phoneticSpelling,
    final String? audioUrl,
    final List<String> tags,
  }) = _$WordImpl;

  @override
  int get id;
  @override
  String get headword;
  @override
  PartOfSpeech get partOfSpeech;
  @override
  CefrLevel get cefrLevel;
  @override
  String get definition;
  @override
  String get exampleSentence;
  @override
  String? get phoneticSpelling;
  @override
  String? get audioUrl;
  @override
  List<String> get tags;

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WordImplCopyWith<_$WordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
