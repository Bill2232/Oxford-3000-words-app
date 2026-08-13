import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:oxford_3000_app/app.dart';
import 'package:oxford_3000_app/data/local/database/app_database.dart';
import 'package:oxford_3000_app/providers/database_provider.dart';

void main() {
  // A single in-memory DB shared across this file's tests. Opening
  // `NativeDatabase.memory()` repeatedly in the same isolate causes
  // resource contention between sqlite3 connections, so tests share one
  // connection rather than each creating (and not fully tearing down)
  // their own.
  late AppDatabase testDb;

  setUpAll(() {
    testDb = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDownAll(() => testDb.close());

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  ProviderScope testApp() {
    return ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(testDb)],
      child: const WordlyApp(),
    );
  }

  testWidgets('WordlyApp boots and shows the home screen', (tester) async {
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
    expect(find.text('Explain word'), findsOneWidget);

    await tester.tap(find.text('Reveal answer'));
    await tester.pumpAndSettle();

    expect(find.text('The word was'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Back to a fresh question.
    expect(find.text('Check'), findsOneWidget);
    expect(find.text('Word 2 this session'), findsOneWidget);
  });

  testWidgets(
      'Explain word opens a dedicated screen and a failed AI call shows an '
      'error with retry, without breaking practice underneath', (tester) async {
    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start Practice'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Explain word'));
    await tester.pumpAndSettle();

    expect(find.text('Explain this word'), findsOneWidget);
    // No ANTHROPIC_API_KEY is configured in the test environment, so the
    // AI section must fail gracefully — not crash, not hang.
    expect(find.text('Retry'), findsOneWidget);
    expect(
      find.text('AI explanation feature is coming soon...'),
      findsOneWidget,
    );

    // Retry re-runs the same (still-failing) call rather than getting stuck.
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Retry'), findsOneWidget);

    // Backing out returns to a fully functional practice screen.
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Practice'), findsOneWidget);
    expect(find.text('Check'), findsOneWidget);
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
}
