import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:oxford_3000_app/app.dart';
import 'package:oxford_3000_app/data/local/database/app_database.dart';
import 'package:oxford_3000_app/data/local/datasources/word_local_datasource.dart';
import 'package:oxford_3000_app/data/local/database/mappers.dart';
import 'package:oxford_3000_app/domain/entities/word.dart';
import 'package:oxford_3000_app/domain/enums/cefr_level.dart';
import 'package:oxford_3000_app/domain/enums/part_of_speech.dart';
import 'package:oxford_3000_app/providers/database_provider.dart';

void main() {
  // A single in-memory DB shared across this file's tests. Opening
  // `NativeDatabase.memory()` repeatedly in the same isolate causes
  // resource contention between sqlite3 connections, so tests share one
  // connection rather than each creating (and not fully tearing down)
  // their own.
  late AppDatabase testDb;

  setUpAll(() async {
    testDb = AppDatabase.forTesting(NativeDatabase.memory());
    // A small fixed word set inserted directly, rather than running the
    // real Oxford3000SeedLoader against the full ~3000-word bundled asset:
    // these tests only exercise navigation/UI wiring and never assert on
    // specific headwords, so production-scale data just adds cost here
    // (and repeatedly hammering the NativeDatabase FFI isolate with a
    // large batch insert plus every subsequent widget test's queries was
    // intermittently timing out `pumpAndSettle` in this environment).
    await WordLocalDataSource(testDb).insertAll(
      List.generate(20, (i) {
        // Letters only (no digit suffix) — the app's answer fields strip
        // non-letters, so a digit-suffixed headword could never be typed
        // back in correctly.
        return Word(
          id: 0,
          headword: 'testword${String.fromCharCode(97 + i)}',
          partOfSpeech: PartOfSpeech.noun,
          cefrLevel: CefrLevel.a1,
          definition: 'A test definition for word $i.',
          exampleSentence: 'This is test word $i in a sentence.',
          tags: const ['core'],
        ).toCompanion();
      }),
    );
  });

  tearDownAll(() => testDb.close());

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  ProviderScope testApp() {
    return ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(testDb),
        // The words are already seeded above; skip the real sync (which
        // would otherwise see this count against the full bundled asset,
        // decide it's a mismatch, and wipe/reseed with production data).
        seedProvider.overrideWith((ref) async {}),
      ],
      child: const LexoraApp(),
    );
  }

  testWidgets('LexoraApp boots and shows the home screen', (tester) async {
    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();

    expect(find.text('Ready to practice?'), findsOneWidget);
    expect(find.text('Start Practice'), findsOneWidget);
  });

  testWidgets('Start Practice opens the practice screen with a word to answer',
      (tester) async {
    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Start Practice'));
    await tester.pumpAndSettle();

    expect(find.text('Practice'), findsOneWidget);
    expect(find.byIcon(Icons.volume_up_rounded), findsOneWidget);
    expect(find.text('Check'), findsOneWidget);
  });

  testWidgets(
      'wrong answer shows error feedback; revealing shows the spelling and lets you continue',
      (tester) async {
    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start Practice'));
    await tester.pumpAndSettle();

    // A string extremely unlikely to match any seeded headword.
    await tester.enterText(find.byType(TextField), 'zzqxvv');
    await tester.tap(find.text('Check'));
    await tester.pumpAndSettle();

    expect(find.text('Not quite — try again'), findsOneWidget);
    expect(find.text('Reveal answer'), findsOneWidget);
    // Not shown yet — the spelling isn't revealed, so this would just be a
    // way to see the answer without a wrong/incomplete attempt counting.
    expect(find.text('Explain word'), findsNothing);

    await tester.tap(find.text('Reveal answer'));
    await tester.pumpAndSettle();

    expect(find.text('The word was'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
    // Now shown — the word is already revealed, so nothing left to give away.
    expect(find.text('Explain word'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Back to a fresh question.
    expect(find.text('Check'), findsOneWidget);
    expect(find.text('Word 2 this session'), findsOneWidget);
  });

  testWidgets(
      'Explain word opens the word detail screen with its definition and '
      'example, without breaking practice underneath', (tester) async {
    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start Practice'));
    await tester.pumpAndSettle();

    // Explain word only appears once the word is no longer hideable behind
    // it — attempt and reveal the answer first, same as a user would have
    // to.
    await tester.enterText(find.byType(TextField), 'zzqxvv');
    await tester.tap(find.text('Check'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reveal answer'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Explain word'));
    await tester.pumpAndSettle();

    expect(find.text('Word detail'), findsOneWidget);
    expect(find.text('Definition'), findsOneWidget);
    expect(find.text('Example'), findsOneWidget);

    // Backing out returns to a fully functional practice screen, still in
    // its revealed state from before.
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Practice'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });

  testWidgets(
      'Vocabulary progress screen shows real stats after attempts have been '
      'recorded, with a CEFR breakdown and weak words section',
      (tester) async {
    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();

    // Record an attempt via practice (earlier tests in this shared-DB file
    // already recorded some too), then check the progress screen.
    await tester.tap(find.text('Start Practice'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'zzqxvv');
    await tester.tap(find.text('Check'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reveal answer'));
    await tester.pumpAndSettle();

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Vocabulary progress'));
    await tester.pumpAndSettle();

    expect(find.text('Vocabulary Progress'), findsOneWidget);
    expect(find.text('Words practiced'), findsOneWidget);
    expect(find.text('Progress by CEFR level'), findsOneWidget);
    expect(find.text('Weak Words'), findsOneWidget);
    expect(find.textContaining('No practice yet'), findsNothing);
  });

  testWidgets(
      'Mark as Mastered removes a word from practice and lets it be '
      'reviewed to completion', (tester) async {
    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start Practice'));
    await tester.pumpAndSettle();

    // Reveal to learn the headword — the letter-box field never shows it,
    // and "Mark as Mastered" is available on the revealed banner too.
    await tester.enterText(find.byType(TextField), 'zzqxvv');
    await tester.tap(find.text('Check'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reveal answer'));
    await tester.pumpAndSettle();

    final headwordFinder = find.byWidgetPredicate(
      (widget) => widget is Text && RegExp(r'^testword[a-z]$').hasMatch(widget.data ?? ''),
    );
    expect(headwordFinder, findsOneWidget);
    final headword = tester.widget<Text>(headwordFinder).data!;

    await tester.tap(find.text('Mark as Mastered'));
    await tester.pumpAndSettle();
    expect(find.text('Mark as mastered?'), findsOneWidget);

    await tester.tap(find.text('Mark as mastered'));
    await tester.pumpAndSettle();
    expect(find.text('Mastered'), findsOneWidget);
    expect(find.text('Mark as Mastered'), findsNothing);

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Mastered Words'));
    await tester.pumpAndSettle();

    expect(find.text('1 word mastered'), findsOneWidget);
    expect(find.text(headword), findsOneWidget);

    await tester.tap(find.text('Review'));
    await tester.pumpAndSettle();

    expect(find.text('Reviewing Mastered Words'), findsOneWidget);
    expect(find.text('1 / 1'), findsOneWidget);

    await tester.enterText(find.byType(TextField), headword);
    await tester.tap(find.text('Check'));
    await tester.pumpAndSettle();

    expect(find.text('Correct!'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Mastered Review Complete'), findsOneWidget);
    expect(find.text('1 word reviewed'), findsOneWidget);

    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    expect(find.text('Mastered Words'), findsOneWidget);
  });

  testWidgets(
      'Tapping the Mastered indicator again undoes an accidental Mark as '
      'Mastered', (tester) async {
    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start Practice'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'zzqxvv');
    await tester.tap(find.text('Check'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reveal answer'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Mark as Mastered'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mark as mastered'));
    await tester.pumpAndSettle();

    expect(find.text('Mastered'), findsOneWidget);
    expect(find.text('Mark as Mastered'), findsNothing);

    // Tapping the now-mastered indicator undoes it, no confirmation needed.
    await tester.tap(find.text('Mastered'));
    await tester.pumpAndSettle();

    expect(find.text('Mark as Mastered'), findsOneWidget);
    expect(find.text('Mastered'), findsNothing);
  });
}
