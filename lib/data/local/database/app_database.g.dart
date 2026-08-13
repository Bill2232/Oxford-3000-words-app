// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WordsTable extends Words with TableInfo<$WordsTable, WordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _headwordMeta = const VerificationMeta(
    'headword',
  );
  @override
  late final GeneratedColumn<String> headword = GeneratedColumn<String>(
    'headword',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _partOfSpeechMeta = const VerificationMeta(
    'partOfSpeech',
  );
  @override
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
    'part_of_speech',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cefrLevelMeta = const VerificationMeta(
    'cefrLevel',
  );
  @override
  late final GeneratedColumn<String> cefrLevel = GeneratedColumn<String>(
    'cefr_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _definitionMeta = const VerificationMeta(
    'definition',
  );
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
    'definition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exampleSentenceMeta = const VerificationMeta(
    'exampleSentence',
  );
  @override
  late final GeneratedColumn<String> exampleSentence = GeneratedColumn<String>(
    'example_sentence',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneticSpellingMeta = const VerificationMeta(
    'phoneticSpelling',
  );
  @override
  late final GeneratedColumn<String> phoneticSpelling = GeneratedColumn<String>(
    'phonetic_spelling',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioUrlMeta = const VerificationMeta(
    'audioUrl',
  );
  @override
  late final GeneratedColumn<String> audioUrl = GeneratedColumn<String>(
    'audio_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    headword,
    partOfSpeech,
    cefrLevel,
    definition,
    exampleSentence,
    phoneticSpelling,
    audioUrl,
    tags,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'words';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('headword')) {
      context.handle(
        _headwordMeta,
        headword.isAcceptableOrUnknown(data['headword']!, _headwordMeta),
      );
    } else if (isInserting) {
      context.missing(_headwordMeta);
    }
    if (data.containsKey('part_of_speech')) {
      context.handle(
        _partOfSpeechMeta,
        partOfSpeech.isAcceptableOrUnknown(
          data['part_of_speech']!,
          _partOfSpeechMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_partOfSpeechMeta);
    }
    if (data.containsKey('cefr_level')) {
      context.handle(
        _cefrLevelMeta,
        cefrLevel.isAcceptableOrUnknown(data['cefr_level']!, _cefrLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_cefrLevelMeta);
    }
    if (data.containsKey('definition')) {
      context.handle(
        _definitionMeta,
        definition.isAcceptableOrUnknown(data['definition']!, _definitionMeta),
      );
    } else if (isInserting) {
      context.missing(_definitionMeta);
    }
    if (data.containsKey('example_sentence')) {
      context.handle(
        _exampleSentenceMeta,
        exampleSentence.isAcceptableOrUnknown(
          data['example_sentence']!,
          _exampleSentenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exampleSentenceMeta);
    }
    if (data.containsKey('phonetic_spelling')) {
      context.handle(
        _phoneticSpellingMeta,
        phoneticSpelling.isAcceptableOrUnknown(
          data['phonetic_spelling']!,
          _phoneticSpellingMeta,
        ),
      );
    }
    if (data.containsKey('audio_url')) {
      context.handle(
        _audioUrlMeta,
        audioUrl.isAcceptableOrUnknown(data['audio_url']!, _audioUrlMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      headword: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}headword'],
      )!,
      partOfSpeech: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_of_speech'],
      )!,
      cefrLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cefr_level'],
      )!,
      definition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}definition'],
      )!,
      exampleSentence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}example_sentence'],
      )!,
      phoneticSpelling: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phonetic_spelling'],
      ),
      audioUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_url'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
    );
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(attachedDatabase, alias);
  }
}

class WordRow extends DataClass implements Insertable<WordRow> {
  final int id;
  final String headword;
  final String partOfSpeech;
  final String cefrLevel;
  final String definition;
  final String exampleSentence;
  final String? phoneticSpelling;
  final String? audioUrl;

  /// Comma-separated tags; small enough not to warrant a join table yet.
  final String tags;
  const WordRow({
    required this.id,
    required this.headword,
    required this.partOfSpeech,
    required this.cefrLevel,
    required this.definition,
    required this.exampleSentence,
    this.phoneticSpelling,
    this.audioUrl,
    required this.tags,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['headword'] = Variable<String>(headword);
    map['part_of_speech'] = Variable<String>(partOfSpeech);
    map['cefr_level'] = Variable<String>(cefrLevel);
    map['definition'] = Variable<String>(definition);
    map['example_sentence'] = Variable<String>(exampleSentence);
    if (!nullToAbsent || phoneticSpelling != null) {
      map['phonetic_spelling'] = Variable<String>(phoneticSpelling);
    }
    if (!nullToAbsent || audioUrl != null) {
      map['audio_url'] = Variable<String>(audioUrl);
    }
    map['tags'] = Variable<String>(tags);
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      id: Value(id),
      headword: Value(headword),
      partOfSpeech: Value(partOfSpeech),
      cefrLevel: Value(cefrLevel),
      definition: Value(definition),
      exampleSentence: Value(exampleSentence),
      phoneticSpelling: phoneticSpelling == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneticSpelling),
      audioUrl: audioUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(audioUrl),
      tags: Value(tags),
    );
  }

  factory WordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordRow(
      id: serializer.fromJson<int>(json['id']),
      headword: serializer.fromJson<String>(json['headword']),
      partOfSpeech: serializer.fromJson<String>(json['partOfSpeech']),
      cefrLevel: serializer.fromJson<String>(json['cefrLevel']),
      definition: serializer.fromJson<String>(json['definition']),
      exampleSentence: serializer.fromJson<String>(json['exampleSentence']),
      phoneticSpelling: serializer.fromJson<String?>(json['phoneticSpelling']),
      audioUrl: serializer.fromJson<String?>(json['audioUrl']),
      tags: serializer.fromJson<String>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'headword': serializer.toJson<String>(headword),
      'partOfSpeech': serializer.toJson<String>(partOfSpeech),
      'cefrLevel': serializer.toJson<String>(cefrLevel),
      'definition': serializer.toJson<String>(definition),
      'exampleSentence': serializer.toJson<String>(exampleSentence),
      'phoneticSpelling': serializer.toJson<String?>(phoneticSpelling),
      'audioUrl': serializer.toJson<String?>(audioUrl),
      'tags': serializer.toJson<String>(tags),
    };
  }

  WordRow copyWith({
    int? id,
    String? headword,
    String? partOfSpeech,
    String? cefrLevel,
    String? definition,
    String? exampleSentence,
    Value<String?> phoneticSpelling = const Value.absent(),
    Value<String?> audioUrl = const Value.absent(),
    String? tags,
  }) => WordRow(
    id: id ?? this.id,
    headword: headword ?? this.headword,
    partOfSpeech: partOfSpeech ?? this.partOfSpeech,
    cefrLevel: cefrLevel ?? this.cefrLevel,
    definition: definition ?? this.definition,
    exampleSentence: exampleSentence ?? this.exampleSentence,
    phoneticSpelling: phoneticSpelling.present
        ? phoneticSpelling.value
        : this.phoneticSpelling,
    audioUrl: audioUrl.present ? audioUrl.value : this.audioUrl,
    tags: tags ?? this.tags,
  );
  WordRow copyWithCompanion(WordsCompanion data) {
    return WordRow(
      id: data.id.present ? data.id.value : this.id,
      headword: data.headword.present ? data.headword.value : this.headword,
      partOfSpeech: data.partOfSpeech.present
          ? data.partOfSpeech.value
          : this.partOfSpeech,
      cefrLevel: data.cefrLevel.present ? data.cefrLevel.value : this.cefrLevel,
      definition: data.definition.present
          ? data.definition.value
          : this.definition,
      exampleSentence: data.exampleSentence.present
          ? data.exampleSentence.value
          : this.exampleSentence,
      phoneticSpelling: data.phoneticSpelling.present
          ? data.phoneticSpelling.value
          : this.phoneticSpelling,
      audioUrl: data.audioUrl.present ? data.audioUrl.value : this.audioUrl,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordRow(')
          ..write('id: $id, ')
          ..write('headword: $headword, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('definition: $definition, ')
          ..write('exampleSentence: $exampleSentence, ')
          ..write('phoneticSpelling: $phoneticSpelling, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    headword,
    partOfSpeech,
    cefrLevel,
    definition,
    exampleSentence,
    phoneticSpelling,
    audioUrl,
    tags,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordRow &&
          other.id == this.id &&
          other.headword == this.headword &&
          other.partOfSpeech == this.partOfSpeech &&
          other.cefrLevel == this.cefrLevel &&
          other.definition == this.definition &&
          other.exampleSentence == this.exampleSentence &&
          other.phoneticSpelling == this.phoneticSpelling &&
          other.audioUrl == this.audioUrl &&
          other.tags == this.tags);
}

class WordsCompanion extends UpdateCompanion<WordRow> {
  final Value<int> id;
  final Value<String> headword;
  final Value<String> partOfSpeech;
  final Value<String> cefrLevel;
  final Value<String> definition;
  final Value<String> exampleSentence;
  final Value<String?> phoneticSpelling;
  final Value<String?> audioUrl;
  final Value<String> tags;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.headword = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.cefrLevel = const Value.absent(),
    this.definition = const Value.absent(),
    this.exampleSentence = const Value.absent(),
    this.phoneticSpelling = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.tags = const Value.absent(),
  });
  WordsCompanion.insert({
    this.id = const Value.absent(),
    required String headword,
    required String partOfSpeech,
    required String cefrLevel,
    required String definition,
    required String exampleSentence,
    this.phoneticSpelling = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.tags = const Value.absent(),
  }) : headword = Value(headword),
       partOfSpeech = Value(partOfSpeech),
       cefrLevel = Value(cefrLevel),
       definition = Value(definition),
       exampleSentence = Value(exampleSentence);
  static Insertable<WordRow> custom({
    Expression<int>? id,
    Expression<String>? headword,
    Expression<String>? partOfSpeech,
    Expression<String>? cefrLevel,
    Expression<String>? definition,
    Expression<String>? exampleSentence,
    Expression<String>? phoneticSpelling,
    Expression<String>? audioUrl,
    Expression<String>? tags,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (headword != null) 'headword': headword,
      if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
      if (cefrLevel != null) 'cefr_level': cefrLevel,
      if (definition != null) 'definition': definition,
      if (exampleSentence != null) 'example_sentence': exampleSentence,
      if (phoneticSpelling != null) 'phonetic_spelling': phoneticSpelling,
      if (audioUrl != null) 'audio_url': audioUrl,
      if (tags != null) 'tags': tags,
    });
  }

  WordsCompanion copyWith({
    Value<int>? id,
    Value<String>? headword,
    Value<String>? partOfSpeech,
    Value<String>? cefrLevel,
    Value<String>? definition,
    Value<String>? exampleSentence,
    Value<String?>? phoneticSpelling,
    Value<String?>? audioUrl,
    Value<String>? tags,
  }) {
    return WordsCompanion(
      id: id ?? this.id,
      headword: headword ?? this.headword,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      definition: definition ?? this.definition,
      exampleSentence: exampleSentence ?? this.exampleSentence,
      phoneticSpelling: phoneticSpelling ?? this.phoneticSpelling,
      audioUrl: audioUrl ?? this.audioUrl,
      tags: tags ?? this.tags,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (headword.present) {
      map['headword'] = Variable<String>(headword.value);
    }
    if (partOfSpeech.present) {
      map['part_of_speech'] = Variable<String>(partOfSpeech.value);
    }
    if (cefrLevel.present) {
      map['cefr_level'] = Variable<String>(cefrLevel.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    if (exampleSentence.present) {
      map['example_sentence'] = Variable<String>(exampleSentence.value);
    }
    if (phoneticSpelling.present) {
      map['phonetic_spelling'] = Variable<String>(phoneticSpelling.value);
    }
    if (audioUrl.present) {
      map['audio_url'] = Variable<String>(audioUrl.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('id: $id, ')
          ..write('headword: $headword, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('definition: $definition, ')
          ..write('exampleSentence: $exampleSentence, ')
          ..write('phoneticSpelling: $phoneticSpelling, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }
}

class $UserWordProgressTableTable extends UserWordProgressTable
    with TableInfo<$UserWordProgressTableTable, UserWordProgressTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserWordProgressTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<int> wordId = GeneratedColumn<int>(
    'word_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES words (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _timesReviewedMeta = const VerificationMeta(
    'timesReviewed',
  );
  @override
  late final GeneratedColumn<int> timesReviewed = GeneratedColumn<int>(
    'times_reviewed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _timesCorrectMeta = const VerificationMeta(
    'timesCorrect',
  );
  @override
  late final GeneratedColumn<int> timesCorrect = GeneratedColumn<int>(
    'times_correct',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _timesIncorrectMeta = const VerificationMeta(
    'timesIncorrect',
  );
  @override
  late final GeneratedColumn<int> timesIncorrect = GeneratedColumn<int>(
    'times_incorrect',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _firstAttemptSuccessesMeta =
      const VerificationMeta('firstAttemptSuccesses');
  @override
  late final GeneratedColumn<int> firstAttemptSuccesses = GeneratedColumn<int>(
    'first_attempt_successes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _revealCountMeta = const VerificationMeta(
    'revealCount',
  );
  @override
  late final GeneratedColumn<int> revealCount = GeneratedColumn<int>(
    'reveal_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _hintCountMeta = const VerificationMeta(
    'hintCount',
  );
  @override
  late final GeneratedColumn<int> hintCount = GeneratedColumn<int>(
    'hint_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _masteryScoreMeta = const VerificationMeta(
    'masteryScore',
  );
  @override
  late final GeneratedColumn<double> masteryScore = GeneratedColumn<double>(
    'mastery_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _masteryLevelMeta = const VerificationMeta(
    'masteryLevel',
  );
  @override
  late final GeneratedColumn<String> masteryLevel = GeneratedColumn<String>(
    'mastery_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('newWord'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _lastReviewedAtMeta = const VerificationMeta(
    'lastReviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastReviewedAt =
      GeneratedColumn<DateTime>(
        'last_reviewed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nextReviewAtMeta = const VerificationMeta(
    'nextReviewAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextReviewAt = GeneratedColumn<DateTime>(
    'next_review_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_word_progress_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserWordProgressTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word_id')) {
      context.handle(
        _wordIdMeta,
        wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta),
      );
    }
    if (data.containsKey('times_reviewed')) {
      context.handle(
        _timesReviewedMeta,
        timesReviewed.isAcceptableOrUnknown(
          data['times_reviewed']!,
          _timesReviewedMeta,
        ),
      );
    }
    if (data.containsKey('times_correct')) {
      context.handle(
        _timesCorrectMeta,
        timesCorrect.isAcceptableOrUnknown(
          data['times_correct']!,
          _timesCorrectMeta,
        ),
      );
    }
    if (data.containsKey('times_incorrect')) {
      context.handle(
        _timesIncorrectMeta,
        timesIncorrect.isAcceptableOrUnknown(
          data['times_incorrect']!,
          _timesIncorrectMeta,
        ),
      );
    }
    if (data.containsKey('first_attempt_successes')) {
      context.handle(
        _firstAttemptSuccessesMeta,
        firstAttemptSuccesses.isAcceptableOrUnknown(
          data['first_attempt_successes']!,
          _firstAttemptSuccessesMeta,
        ),
      );
    }
    if (data.containsKey('reveal_count')) {
      context.handle(
        _revealCountMeta,
        revealCount.isAcceptableOrUnknown(
          data['reveal_count']!,
          _revealCountMeta,
        ),
      );
    }
    if (data.containsKey('hint_count')) {
      context.handle(
        _hintCountMeta,
        hintCount.isAcceptableOrUnknown(data['hint_count']!, _hintCountMeta),
      );
    }
    if (data.containsKey('mastery_score')) {
      context.handle(
        _masteryScoreMeta,
        masteryScore.isAcceptableOrUnknown(
          data['mastery_score']!,
          _masteryScoreMeta,
        ),
      );
    }
    if (data.containsKey('mastery_level')) {
      context.handle(
        _masteryLevelMeta,
        masteryLevel.isAcceptableOrUnknown(
          data['mastery_level']!,
          _masteryLevelMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('last_reviewed_at')) {
      context.handle(
        _lastReviewedAtMeta,
        lastReviewedAt.isAcceptableOrUnknown(
          data['last_reviewed_at']!,
          _lastReviewedAtMeta,
        ),
      );
    }
    if (data.containsKey('next_review_at')) {
      context.handle(
        _nextReviewAtMeta,
        nextReviewAt.isAcceptableOrUnknown(
          data['next_review_at']!,
          _nextReviewAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {wordId};
  @override
  UserWordProgressTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserWordProgressTableData(
      wordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word_id'],
      )!,
      timesReviewed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}times_reviewed'],
      )!,
      timesCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}times_correct'],
      )!,
      timesIncorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}times_incorrect'],
      )!,
      firstAttemptSuccesses: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}first_attempt_successes'],
      )!,
      revealCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reveal_count'],
      )!,
      hintCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hint_count'],
      )!,
      masteryScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mastery_score'],
      )!,
      masteryLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mastery_level'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastReviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reviewed_at'],
      ),
      nextReviewAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_review_at'],
      ),
    );
  }

  @override
  $UserWordProgressTableTable createAlias(String alias) {
    return $UserWordProgressTableTable(attachedDatabase, alias);
  }
}

class UserWordProgressTableData extends DataClass
    implements Insertable<UserWordProgressTableData> {
  final int wordId;
  final int timesReviewed;
  final int timesCorrect;
  final int timesIncorrect;
  final int firstAttemptSuccesses;
  final int revealCount;
  final int hintCount;
  final double masteryScore;
  final String masteryLevel;
  final DateTime createdAt;
  final DateTime? lastReviewedAt;
  final DateTime? nextReviewAt;
  const UserWordProgressTableData({
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
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word_id'] = Variable<int>(wordId);
    map['times_reviewed'] = Variable<int>(timesReviewed);
    map['times_correct'] = Variable<int>(timesCorrect);
    map['times_incorrect'] = Variable<int>(timesIncorrect);
    map['first_attempt_successes'] = Variable<int>(firstAttemptSuccesses);
    map['reveal_count'] = Variable<int>(revealCount);
    map['hint_count'] = Variable<int>(hintCount);
    map['mastery_score'] = Variable<double>(masteryScore);
    map['mastery_level'] = Variable<String>(masteryLevel);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastReviewedAt != null) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt);
    }
    if (!nullToAbsent || nextReviewAt != null) {
      map['next_review_at'] = Variable<DateTime>(nextReviewAt);
    }
    return map;
  }

  UserWordProgressTableCompanion toCompanion(bool nullToAbsent) {
    return UserWordProgressTableCompanion(
      wordId: Value(wordId),
      timesReviewed: Value(timesReviewed),
      timesCorrect: Value(timesCorrect),
      timesIncorrect: Value(timesIncorrect),
      firstAttemptSuccesses: Value(firstAttemptSuccesses),
      revealCount: Value(revealCount),
      hintCount: Value(hintCount),
      masteryScore: Value(masteryScore),
      masteryLevel: Value(masteryLevel),
      createdAt: Value(createdAt),
      lastReviewedAt: lastReviewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewedAt),
      nextReviewAt: nextReviewAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextReviewAt),
    );
  }

  factory UserWordProgressTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserWordProgressTableData(
      wordId: serializer.fromJson<int>(json['wordId']),
      timesReviewed: serializer.fromJson<int>(json['timesReviewed']),
      timesCorrect: serializer.fromJson<int>(json['timesCorrect']),
      timesIncorrect: serializer.fromJson<int>(json['timesIncorrect']),
      firstAttemptSuccesses: serializer.fromJson<int>(
        json['firstAttemptSuccesses'],
      ),
      revealCount: serializer.fromJson<int>(json['revealCount']),
      hintCount: serializer.fromJson<int>(json['hintCount']),
      masteryScore: serializer.fromJson<double>(json['masteryScore']),
      masteryLevel: serializer.fromJson<String>(json['masteryLevel']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastReviewedAt: serializer.fromJson<DateTime?>(json['lastReviewedAt']),
      nextReviewAt: serializer.fromJson<DateTime?>(json['nextReviewAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'wordId': serializer.toJson<int>(wordId),
      'timesReviewed': serializer.toJson<int>(timesReviewed),
      'timesCorrect': serializer.toJson<int>(timesCorrect),
      'timesIncorrect': serializer.toJson<int>(timesIncorrect),
      'firstAttemptSuccesses': serializer.toJson<int>(firstAttemptSuccesses),
      'revealCount': serializer.toJson<int>(revealCount),
      'hintCount': serializer.toJson<int>(hintCount),
      'masteryScore': serializer.toJson<double>(masteryScore),
      'masteryLevel': serializer.toJson<String>(masteryLevel),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastReviewedAt': serializer.toJson<DateTime?>(lastReviewedAt),
      'nextReviewAt': serializer.toJson<DateTime?>(nextReviewAt),
    };
  }

  UserWordProgressTableData copyWith({
    int? wordId,
    int? timesReviewed,
    int? timesCorrect,
    int? timesIncorrect,
    int? firstAttemptSuccesses,
    int? revealCount,
    int? hintCount,
    double? masteryScore,
    String? masteryLevel,
    DateTime? createdAt,
    Value<DateTime?> lastReviewedAt = const Value.absent(),
    Value<DateTime?> nextReviewAt = const Value.absent(),
  }) => UserWordProgressTableData(
    wordId: wordId ?? this.wordId,
    timesReviewed: timesReviewed ?? this.timesReviewed,
    timesCorrect: timesCorrect ?? this.timesCorrect,
    timesIncorrect: timesIncorrect ?? this.timesIncorrect,
    firstAttemptSuccesses: firstAttemptSuccesses ?? this.firstAttemptSuccesses,
    revealCount: revealCount ?? this.revealCount,
    hintCount: hintCount ?? this.hintCount,
    masteryScore: masteryScore ?? this.masteryScore,
    masteryLevel: masteryLevel ?? this.masteryLevel,
    createdAt: createdAt ?? this.createdAt,
    lastReviewedAt: lastReviewedAt.present
        ? lastReviewedAt.value
        : this.lastReviewedAt,
    nextReviewAt: nextReviewAt.present ? nextReviewAt.value : this.nextReviewAt,
  );
  UserWordProgressTableData copyWithCompanion(
    UserWordProgressTableCompanion data,
  ) {
    return UserWordProgressTableData(
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      timesReviewed: data.timesReviewed.present
          ? data.timesReviewed.value
          : this.timesReviewed,
      timesCorrect: data.timesCorrect.present
          ? data.timesCorrect.value
          : this.timesCorrect,
      timesIncorrect: data.timesIncorrect.present
          ? data.timesIncorrect.value
          : this.timesIncorrect,
      firstAttemptSuccesses: data.firstAttemptSuccesses.present
          ? data.firstAttemptSuccesses.value
          : this.firstAttemptSuccesses,
      revealCount: data.revealCount.present
          ? data.revealCount.value
          : this.revealCount,
      hintCount: data.hintCount.present ? data.hintCount.value : this.hintCount,
      masteryScore: data.masteryScore.present
          ? data.masteryScore.value
          : this.masteryScore,
      masteryLevel: data.masteryLevel.present
          ? data.masteryLevel.value
          : this.masteryLevel,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastReviewedAt: data.lastReviewedAt.present
          ? data.lastReviewedAt.value
          : this.lastReviewedAt,
      nextReviewAt: data.nextReviewAt.present
          ? data.nextReviewAt.value
          : this.nextReviewAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserWordProgressTableData(')
          ..write('wordId: $wordId, ')
          ..write('timesReviewed: $timesReviewed, ')
          ..write('timesCorrect: $timesCorrect, ')
          ..write('timesIncorrect: $timesIncorrect, ')
          ..write('firstAttemptSuccesses: $firstAttemptSuccesses, ')
          ..write('revealCount: $revealCount, ')
          ..write('hintCount: $hintCount, ')
          ..write('masteryScore: $masteryScore, ')
          ..write('masteryLevel: $masteryLevel, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('nextReviewAt: $nextReviewAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserWordProgressTableData &&
          other.wordId == this.wordId &&
          other.timesReviewed == this.timesReviewed &&
          other.timesCorrect == this.timesCorrect &&
          other.timesIncorrect == this.timesIncorrect &&
          other.firstAttemptSuccesses == this.firstAttemptSuccesses &&
          other.revealCount == this.revealCount &&
          other.hintCount == this.hintCount &&
          other.masteryScore == this.masteryScore &&
          other.masteryLevel == this.masteryLevel &&
          other.createdAt == this.createdAt &&
          other.lastReviewedAt == this.lastReviewedAt &&
          other.nextReviewAt == this.nextReviewAt);
}

class UserWordProgressTableCompanion
    extends UpdateCompanion<UserWordProgressTableData> {
  final Value<int> wordId;
  final Value<int> timesReviewed;
  final Value<int> timesCorrect;
  final Value<int> timesIncorrect;
  final Value<int> firstAttemptSuccesses;
  final Value<int> revealCount;
  final Value<int> hintCount;
  final Value<double> masteryScore;
  final Value<String> masteryLevel;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastReviewedAt;
  final Value<DateTime?> nextReviewAt;
  const UserWordProgressTableCompanion({
    this.wordId = const Value.absent(),
    this.timesReviewed = const Value.absent(),
    this.timesCorrect = const Value.absent(),
    this.timesIncorrect = const Value.absent(),
    this.firstAttemptSuccesses = const Value.absent(),
    this.revealCount = const Value.absent(),
    this.hintCount = const Value.absent(),
    this.masteryScore = const Value.absent(),
    this.masteryLevel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
  });
  UserWordProgressTableCompanion.insert({
    this.wordId = const Value.absent(),
    this.timesReviewed = const Value.absent(),
    this.timesCorrect = const Value.absent(),
    this.timesIncorrect = const Value.absent(),
    this.firstAttemptSuccesses = const Value.absent(),
    this.revealCount = const Value.absent(),
    this.hintCount = const Value.absent(),
    this.masteryScore = const Value.absent(),
    this.masteryLevel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
  });
  static Insertable<UserWordProgressTableData> custom({
    Expression<int>? wordId,
    Expression<int>? timesReviewed,
    Expression<int>? timesCorrect,
    Expression<int>? timesIncorrect,
    Expression<int>? firstAttemptSuccesses,
    Expression<int>? revealCount,
    Expression<int>? hintCount,
    Expression<double>? masteryScore,
    Expression<String>? masteryLevel,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastReviewedAt,
    Expression<DateTime>? nextReviewAt,
  }) {
    return RawValuesInsertable({
      if (wordId != null) 'word_id': wordId,
      if (timesReviewed != null) 'times_reviewed': timesReviewed,
      if (timesCorrect != null) 'times_correct': timesCorrect,
      if (timesIncorrect != null) 'times_incorrect': timesIncorrect,
      if (firstAttemptSuccesses != null)
        'first_attempt_successes': firstAttemptSuccesses,
      if (revealCount != null) 'reveal_count': revealCount,
      if (hintCount != null) 'hint_count': hintCount,
      if (masteryScore != null) 'mastery_score': masteryScore,
      if (masteryLevel != null) 'mastery_level': masteryLevel,
      if (createdAt != null) 'created_at': createdAt,
      if (lastReviewedAt != null) 'last_reviewed_at': lastReviewedAt,
      if (nextReviewAt != null) 'next_review_at': nextReviewAt,
    });
  }

  UserWordProgressTableCompanion copyWith({
    Value<int>? wordId,
    Value<int>? timesReviewed,
    Value<int>? timesCorrect,
    Value<int>? timesIncorrect,
    Value<int>? firstAttemptSuccesses,
    Value<int>? revealCount,
    Value<int>? hintCount,
    Value<double>? masteryScore,
    Value<String>? masteryLevel,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastReviewedAt,
    Value<DateTime?>? nextReviewAt,
  }) {
    return UserWordProgressTableCompanion(
      wordId: wordId ?? this.wordId,
      timesReviewed: timesReviewed ?? this.timesReviewed,
      timesCorrect: timesCorrect ?? this.timesCorrect,
      timesIncorrect: timesIncorrect ?? this.timesIncorrect,
      firstAttemptSuccesses:
          firstAttemptSuccesses ?? this.firstAttemptSuccesses,
      revealCount: revealCount ?? this.revealCount,
      hintCount: hintCount ?? this.hintCount,
      masteryScore: masteryScore ?? this.masteryScore,
      masteryLevel: masteryLevel ?? this.masteryLevel,
      createdAt: createdAt ?? this.createdAt,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (wordId.present) {
      map['word_id'] = Variable<int>(wordId.value);
    }
    if (timesReviewed.present) {
      map['times_reviewed'] = Variable<int>(timesReviewed.value);
    }
    if (timesCorrect.present) {
      map['times_correct'] = Variable<int>(timesCorrect.value);
    }
    if (timesIncorrect.present) {
      map['times_incorrect'] = Variable<int>(timesIncorrect.value);
    }
    if (firstAttemptSuccesses.present) {
      map['first_attempt_successes'] = Variable<int>(
        firstAttemptSuccesses.value,
      );
    }
    if (revealCount.present) {
      map['reveal_count'] = Variable<int>(revealCount.value);
    }
    if (hintCount.present) {
      map['hint_count'] = Variable<int>(hintCount.value);
    }
    if (masteryScore.present) {
      map['mastery_score'] = Variable<double>(masteryScore.value);
    }
    if (masteryLevel.present) {
      map['mastery_level'] = Variable<String>(masteryLevel.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastReviewedAt.present) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt.value);
    }
    if (nextReviewAt.present) {
      map['next_review_at'] = Variable<DateTime>(nextReviewAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserWordProgressTableCompanion(')
          ..write('wordId: $wordId, ')
          ..write('timesReviewed: $timesReviewed, ')
          ..write('timesCorrect: $timesCorrect, ')
          ..write('timesIncorrect: $timesIncorrect, ')
          ..write('firstAttemptSuccesses: $firstAttemptSuccesses, ')
          ..write('revealCount: $revealCount, ')
          ..write('hintCount: $hintCount, ')
          ..write('masteryScore: $masteryScore, ')
          ..write('masteryLevel: $masteryLevel, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('nextReviewAt: $nextReviewAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WordsTable words = $WordsTable(this);
  late final $UserWordProgressTableTable userWordProgressTable =
      $UserWordProgressTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    words,
    userWordProgressTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'words',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('user_word_progress_table', kind: UpdateKind.delete),
      ],
    ),
  ]);
}

typedef $$WordsTableCreateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      required String headword,
      required String partOfSpeech,
      required String cefrLevel,
      required String definition,
      required String exampleSentence,
      Value<String?> phoneticSpelling,
      Value<String?> audioUrl,
      Value<String> tags,
    });
typedef $$WordsTableUpdateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      Value<String> headword,
      Value<String> partOfSpeech,
      Value<String> cefrLevel,
      Value<String> definition,
      Value<String> exampleSentence,
      Value<String?> phoneticSpelling,
      Value<String?> audioUrl,
      Value<String> tags,
    });

final class $$WordsTableReferences
    extends BaseReferences<_$AppDatabase, $WordsTable, WordRow> {
  $$WordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $UserWordProgressTableTable,
    List<UserWordProgressTableData>
  >
  _userWordProgressTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.userWordProgressTable,
        aliasName: $_aliasNameGenerator(
          db.words.id,
          db.userWordProgressTable.wordId,
        ),
      );

  $$UserWordProgressTableTableProcessedTableManager
  get userWordProgressTableRefs {
    final manager = $$UserWordProgressTableTableTableManager(
      $_db,
      $_db.userWordProgressTable,
    ).filter((f) => f.wordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userWordProgressTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WordsTableFilterComposer extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get headword => $composableBuilder(
    column: $table.headword,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exampleSentence => $composableBuilder(
    column: $table.exampleSentence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneticSpelling => $composableBuilder(
    column: $table.phoneticSpelling,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userWordProgressTableRefs(
    Expression<bool> Function($$UserWordProgressTableTableFilterComposer f) f,
  ) {
    final $$UserWordProgressTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userWordProgressTable,
          getReferencedColumn: (t) => t.wordId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserWordProgressTableTableFilterComposer(
                $db: $db,
                $table: $db.userWordProgressTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$WordsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get headword => $composableBuilder(
    column: $table.headword,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exampleSentence => $composableBuilder(
    column: $table.exampleSentence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneticSpelling => $composableBuilder(
    column: $table.phoneticSpelling,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get headword =>
      $composableBuilder(column: $table.headword, builder: (column) => column);

  GeneratedColumn<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cefrLevel =>
      $composableBuilder(column: $table.cefrLevel, builder: (column) => column);

  GeneratedColumn<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exampleSentence => $composableBuilder(
    column: $table.exampleSentence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneticSpelling => $composableBuilder(
    column: $table.phoneticSpelling,
    builder: (column) => column,
  );

  GeneratedColumn<String> get audioUrl =>
      $composableBuilder(column: $table.audioUrl, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  Expression<T> userWordProgressTableRefs<T extends Object>(
    Expression<T> Function($$UserWordProgressTableTableAnnotationComposer a) f,
  ) {
    final $$UserWordProgressTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userWordProgressTable,
          getReferencedColumn: (t) => t.wordId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserWordProgressTableTableAnnotationComposer(
                $db: $db,
                $table: $db.userWordProgressTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$WordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordsTable,
          WordRow,
          $$WordsTableFilterComposer,
          $$WordsTableOrderingComposer,
          $$WordsTableAnnotationComposer,
          $$WordsTableCreateCompanionBuilder,
          $$WordsTableUpdateCompanionBuilder,
          (WordRow, $$WordsTableReferences),
          WordRow,
          PrefetchHooks Function({bool userWordProgressTableRefs})
        > {
  $$WordsTableTableManager(_$AppDatabase db, $WordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> headword = const Value.absent(),
                Value<String> partOfSpeech = const Value.absent(),
                Value<String> cefrLevel = const Value.absent(),
                Value<String> definition = const Value.absent(),
                Value<String> exampleSentence = const Value.absent(),
                Value<String?> phoneticSpelling = const Value.absent(),
                Value<String?> audioUrl = const Value.absent(),
                Value<String> tags = const Value.absent(),
              }) => WordsCompanion(
                id: id,
                headword: headword,
                partOfSpeech: partOfSpeech,
                cefrLevel: cefrLevel,
                definition: definition,
                exampleSentence: exampleSentence,
                phoneticSpelling: phoneticSpelling,
                audioUrl: audioUrl,
                tags: tags,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String headword,
                required String partOfSpeech,
                required String cefrLevel,
                required String definition,
                required String exampleSentence,
                Value<String?> phoneticSpelling = const Value.absent(),
                Value<String?> audioUrl = const Value.absent(),
                Value<String> tags = const Value.absent(),
              }) => WordsCompanion.insert(
                id: id,
                headword: headword,
                partOfSpeech: partOfSpeech,
                cefrLevel: cefrLevel,
                definition: definition,
                exampleSentence: exampleSentence,
                phoneticSpelling: phoneticSpelling,
                audioUrl: audioUrl,
                tags: tags,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$WordsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({userWordProgressTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userWordProgressTableRefs) db.userWordProgressTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userWordProgressTableRefs)
                    await $_getPrefetchedData<
                      WordRow,
                      $WordsTable,
                      UserWordProgressTableData
                    >(
                      currentTable: table,
                      referencedTable: $$WordsTableReferences
                          ._userWordProgressTableRefsTable(db),
                      managerFromTypedResult: (p0) => $$WordsTableReferences(
                        db,
                        table,
                        p0,
                      ).userWordProgressTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.wordId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$WordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordsTable,
      WordRow,
      $$WordsTableFilterComposer,
      $$WordsTableOrderingComposer,
      $$WordsTableAnnotationComposer,
      $$WordsTableCreateCompanionBuilder,
      $$WordsTableUpdateCompanionBuilder,
      (WordRow, $$WordsTableReferences),
      WordRow,
      PrefetchHooks Function({bool userWordProgressTableRefs})
    >;
typedef $$UserWordProgressTableTableCreateCompanionBuilder =
    UserWordProgressTableCompanion Function({
      Value<int> wordId,
      Value<int> timesReviewed,
      Value<int> timesCorrect,
      Value<int> timesIncorrect,
      Value<int> firstAttemptSuccesses,
      Value<int> revealCount,
      Value<int> hintCount,
      Value<double> masteryScore,
      Value<String> masteryLevel,
      Value<DateTime> createdAt,
      Value<DateTime?> lastReviewedAt,
      Value<DateTime?> nextReviewAt,
    });
typedef $$UserWordProgressTableTableUpdateCompanionBuilder =
    UserWordProgressTableCompanion Function({
      Value<int> wordId,
      Value<int> timesReviewed,
      Value<int> timesCorrect,
      Value<int> timesIncorrect,
      Value<int> firstAttemptSuccesses,
      Value<int> revealCount,
      Value<int> hintCount,
      Value<double> masteryScore,
      Value<String> masteryLevel,
      Value<DateTime> createdAt,
      Value<DateTime?> lastReviewedAt,
      Value<DateTime?> nextReviewAt,
    });

final class $$UserWordProgressTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UserWordProgressTableTable,
          UserWordProgressTableData
        > {
  $$UserWordProgressTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WordsTable _wordIdTable(_$AppDatabase db) => db.words.createAlias(
    $_aliasNameGenerator(db.userWordProgressTable.wordId, db.words.id),
  );

  $$WordsTableProcessedTableManager get wordId {
    final $_column = $_itemColumn<int>('word_id')!;

    final manager = $$WordsTableTableManager(
      $_db,
      $_db.words,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserWordProgressTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserWordProgressTableTable> {
  $$UserWordProgressTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get timesReviewed => $composableBuilder(
    column: $table.timesReviewed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timesCorrect => $composableBuilder(
    column: $table.timesCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timesIncorrect => $composableBuilder(
    column: $table.timesIncorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get firstAttemptSuccesses => $composableBuilder(
    column: $table.firstAttemptSuccesses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revealCount => $composableBuilder(
    column: $table.revealCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hintCount => $composableBuilder(
    column: $table.hintCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get masteryScore => $composableBuilder(
    column: $table.masteryScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get masteryLevel => $composableBuilder(
    column: $table.masteryLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WordsTableFilterComposer get wordId {
    final $$WordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableFilterComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserWordProgressTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserWordProgressTableTable> {
  $$UserWordProgressTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get timesReviewed => $composableBuilder(
    column: $table.timesReviewed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timesCorrect => $composableBuilder(
    column: $table.timesCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timesIncorrect => $composableBuilder(
    column: $table.timesIncorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get firstAttemptSuccesses => $composableBuilder(
    column: $table.firstAttemptSuccesses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revealCount => $composableBuilder(
    column: $table.revealCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hintCount => $composableBuilder(
    column: $table.hintCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get masteryScore => $composableBuilder(
    column: $table.masteryScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get masteryLevel => $composableBuilder(
    column: $table.masteryLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WordsTableOrderingComposer get wordId {
    final $$WordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableOrderingComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserWordProgressTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserWordProgressTableTable> {
  $$UserWordProgressTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get timesReviewed => $composableBuilder(
    column: $table.timesReviewed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timesCorrect => $composableBuilder(
    column: $table.timesCorrect,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timesIncorrect => $composableBuilder(
    column: $table.timesIncorrect,
    builder: (column) => column,
  );

  GeneratedColumn<int> get firstAttemptSuccesses => $composableBuilder(
    column: $table.firstAttemptSuccesses,
    builder: (column) => column,
  );

  GeneratedColumn<int> get revealCount => $composableBuilder(
    column: $table.revealCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hintCount =>
      $composableBuilder(column: $table.hintCount, builder: (column) => column);

  GeneratedColumn<double> get masteryScore => $composableBuilder(
    column: $table.masteryScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get masteryLevel => $composableBuilder(
    column: $table.masteryLevel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => column,
  );

  $$WordsTableAnnotationComposer get wordId {
    final $$WordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableAnnotationComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserWordProgressTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserWordProgressTableTable,
          UserWordProgressTableData,
          $$UserWordProgressTableTableFilterComposer,
          $$UserWordProgressTableTableOrderingComposer,
          $$UserWordProgressTableTableAnnotationComposer,
          $$UserWordProgressTableTableCreateCompanionBuilder,
          $$UserWordProgressTableTableUpdateCompanionBuilder,
          (UserWordProgressTableData, $$UserWordProgressTableTableReferences),
          UserWordProgressTableData,
          PrefetchHooks Function({bool wordId})
        > {
  $$UserWordProgressTableTableTableManager(
    _$AppDatabase db,
    $UserWordProgressTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserWordProgressTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$UserWordProgressTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UserWordProgressTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> wordId = const Value.absent(),
                Value<int> timesReviewed = const Value.absent(),
                Value<int> timesCorrect = const Value.absent(),
                Value<int> timesIncorrect = const Value.absent(),
                Value<int> firstAttemptSuccesses = const Value.absent(),
                Value<int> revealCount = const Value.absent(),
                Value<int> hintCount = const Value.absent(),
                Value<double> masteryScore = const Value.absent(),
                Value<String> masteryLevel = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                Value<DateTime?> nextReviewAt = const Value.absent(),
              }) => UserWordProgressTableCompanion(
                wordId: wordId,
                timesReviewed: timesReviewed,
                timesCorrect: timesCorrect,
                timesIncorrect: timesIncorrect,
                firstAttemptSuccesses: firstAttemptSuccesses,
                revealCount: revealCount,
                hintCount: hintCount,
                masteryScore: masteryScore,
                masteryLevel: masteryLevel,
                createdAt: createdAt,
                lastReviewedAt: lastReviewedAt,
                nextReviewAt: nextReviewAt,
              ),
          createCompanionCallback:
              ({
                Value<int> wordId = const Value.absent(),
                Value<int> timesReviewed = const Value.absent(),
                Value<int> timesCorrect = const Value.absent(),
                Value<int> timesIncorrect = const Value.absent(),
                Value<int> firstAttemptSuccesses = const Value.absent(),
                Value<int> revealCount = const Value.absent(),
                Value<int> hintCount = const Value.absent(),
                Value<double> masteryScore = const Value.absent(),
                Value<String> masteryLevel = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                Value<DateTime?> nextReviewAt = const Value.absent(),
              }) => UserWordProgressTableCompanion.insert(
                wordId: wordId,
                timesReviewed: timesReviewed,
                timesCorrect: timesCorrect,
                timesIncorrect: timesIncorrect,
                firstAttemptSuccesses: firstAttemptSuccesses,
                revealCount: revealCount,
                hintCount: hintCount,
                masteryScore: masteryScore,
                masteryLevel: masteryLevel,
                createdAt: createdAt,
                lastReviewedAt: lastReviewedAt,
                nextReviewAt: nextReviewAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserWordProgressTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (wordId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.wordId,
                                referencedTable:
                                    $$UserWordProgressTableTableReferences
                                        ._wordIdTable(db),
                                referencedColumn:
                                    $$UserWordProgressTableTableReferences
                                        ._wordIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserWordProgressTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserWordProgressTableTable,
      UserWordProgressTableData,
      $$UserWordProgressTableTableFilterComposer,
      $$UserWordProgressTableTableOrderingComposer,
      $$UserWordProgressTableTableAnnotationComposer,
      $$UserWordProgressTableTableCreateCompanionBuilder,
      $$UserWordProgressTableTableUpdateCompanionBuilder,
      (UserWordProgressTableData, $$UserWordProgressTableTableReferences),
      UserWordProgressTableData,
      PrefetchHooks Function({bool wordId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WordsTableTableManager get words =>
      $$WordsTableTableManager(_db, _db.words);
  $$UserWordProgressTableTableTableManager get userWordProgressTable =>
      $$UserWordProgressTableTableTableManager(_db, _db.userWordProgressTable);
}
