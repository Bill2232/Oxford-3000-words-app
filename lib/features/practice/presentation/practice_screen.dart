import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_semantic_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_confirm_dialog.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_shake.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../domain/entities/word.dart';
import '../application/answer_field_style.dart';
import '../application/answer_field_style_controller.dart';
import '../application/check_result.dart';
import '../application/practice_controller.dart';
import '../application/practice_state.dart';
import 'widgets/accent_quick_switch.dart';
import 'widgets/practice_letter_input.dart';
import 'widgets/practice_plain_text_field.dart';
import 'widgets/practice_play_button.dart';

/// How long a newly-shown word waits before it's automatically spoken —
/// long enough that it doesn't feel like it's talking over the word
/// appearing, short enough to still feel immediate.
const _autoPlayDelay = Duration(milliseconds: 650);

class PracticeScreen extends ConsumerStatefulWidget {
  const PracticeScreen({super.key});

  @override
  ConsumerState<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends ConsumerState<PracticeScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  // Anchors the Check/feedback area so it can be explicitly scrolled above
  // the keyboard — the on-screen keyboard covering the Check button (and,
  // with the letter-box style, a long word wrapping to a second row pushing
  // it down further still) is exactly the problem this works around.
  final _feedbackKey = GlobalKey();
  int _shakeTrigger = 0;
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _autoPlayTimer?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) _scrollFeedbackIntoView();
  }

  /// Waits for the keyboard's own show animation to (roughly) finish, then
  /// scrolls the Check/feedback area fully above it. Also called after a
  /// check/reveal, since the feedback area's content (and therefore height)
  /// changes shape at that point too.
  void _scrollFeedbackIntoView() {
    Future.delayed(const Duration(milliseconds: 280), () {
      if (!mounted) return;
      final feedbackContext = _feedbackKey.currentContext;
      if (feedbackContext == null) return;
      // Fetched fresh from the key after the `mounted` check above, not a
      // context captured before the gap — safe despite the lint.
      Scrollable.ensureVisible(
        // ignore: use_build_context_synchronously
        feedbackContext,
        duration: AppMotion.medium,
        curve: AppMotion.standard,
        alignment: 1,
      );
    });
  }

  /// Schedules pronunciation to play automatically whenever the word
  /// actually changes (initial load or "Next word") — not on every state
  /// update, so a check/reveal result on the *same* word doesn't replay it.
  void _onPracticeStateChange(
    AsyncValue<PracticeState>? previous,
    AsyncValue<PracticeState> next,
  ) {
    final previousWordId = previous?.valueOrNull?.word.id;
    final nextWord = next.valueOrNull?.word;
    if (nextWord == null || nextWord.id == previousWordId) return;

    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer(_autoPlayDelay, () {
      if (!mounted) return;
      ref.read(practiceControllerProvider.notifier).playAudio();
    });
  }

  Future<void> _check() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final correct =
        await ref.read(practiceControllerProvider.notifier).checkAnswer(text);
    if (!correct) setState(() => _shakeTrigger++);
    _scrollFeedbackIntoView();
  }

  void _reveal() {
    ref.read(practiceControllerProvider.notifier).revealAnswer();
    _scrollFeedbackIntoView();
  }

  /// While the user edits their answer after a wrong (not yet revealed)
  /// attempt, the letter boxes should read as neutral again rather than
  /// staying red — the red state describes the *previous* attempt, not
  /// what's currently typed.
  void _onLetterChanged(String _) {
    ref.read(practiceControllerProvider.notifier).clearResult();
  }

  void _next() {
    _controller.clear();
    ref.read(practiceControllerProvider.notifier).nextWord();
    _focusNode.requestFocus();
  }

  Future<void> _markAsMastered() async {
    final prefs = ref.read(markAsMasteredPreferencesProvider);
    final skipConfirmation = await prefs.getSkipConfirmation();

    if (!skipConfirmation) {
      if (!mounted) return;
      final result = await showAppConfirmDialog(
        context,
        title: 'Mark as mastered?',
        message: 'This word will be removed from normal practice and added '
            'to your Mastered Words.',
        confirmLabel: 'Mark as mastered',
        checkboxLabel: "Don't ask me again",
      );
      if (!result.confirmed) return;
      if (result.dontShowAgain) {
        await prefs.setSkipConfirmation(true);
      }
    }

    if (!mounted) return;
    await ref.read(practiceControllerProvider.notifier).markCurrentWordAsMastered();
  }

  // Reverses an accidental "Mark as Mastered" tap — no confirmation, since
  // that would defeat the point of a quick undo.
  Future<void> _unmarkAsMastered() async {
    await ref.read(practiceControllerProvider.notifier).unmarkCurrentWordAsMastered();
  }

  @override
  Widget build(BuildContext context) {
    final stateAsync = ref.watch(practiceControllerProvider);
    ref.listen<AsyncValue<PracticeState>>(
      practiceControllerProvider,
      _onPracticeStateChange,
    );
    final answerFieldStyle = ref.watch(answerFieldStyleControllerProvider);

    return AppScaffold(
      title: 'Practice',
      body: stateAsync.when(
        loading: () => const LoadingIndicator(message: 'Preparing your practice…'),
        error: (error, stackTrace) => EmptyState(
          icon: Icons.error_outline,
          message: 'Could not start practice. Please try again.',
          onRetry: () => ref.invalidate(practiceControllerProvider),
        ),
        data: (state) => _PracticeContent(
          state: state,
          controller: _controller,
          focusNode: _focusNode,
          feedbackKey: _feedbackKey,
          shakeTrigger: _shakeTrigger,
          answerFieldStyle: answerFieldStyle,
          onCheck: _check,
          onReveal: _reveal,
          onNext: _next,
          onLetterChanged: _onLetterChanged,
          onPlayAudio: () =>
              ref.read(practiceControllerProvider.notifier).playAudio(),
          onMarkMastered: _markAsMastered,
          onUnmarkMastered: _unmarkAsMastered,
        ),
      ),
    );
  }
}

class _PracticeContent extends StatelessWidget {
  const _PracticeContent({
    required this.state,
    required this.controller,
    required this.focusNode,
    required this.feedbackKey,
    required this.shakeTrigger,
    required this.answerFieldStyle,
    required this.onCheck,
    required this.onReveal,
    required this.onNext,
    required this.onLetterChanged,
    required this.onPlayAudio,
    required this.onMarkMastered,
    required this.onUnmarkMastered,
  });

  final PracticeState state;
  final TextEditingController controller;
  final FocusNode focusNode;
  final GlobalKey feedbackKey;
  final int shakeTrigger;
  final AnswerFieldStyle answerFieldStyle;
  final VoidCallback onCheck;
  final VoidCallback onReveal;
  final VoidCallback onNext;
  final ValueChanged<String> onLetterChanged;
  final VoidCallback onPlayAudio;
  final VoidCallback onMarkMastered;
  final VoidCallback onUnmarkMastered;

  bool get _isDone =>
      state.result == CheckResult.correct || state.isRevealed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // The keyboard covering the Check button — worse still with a long word
    // wrapping the letter boxes to a second row — is exactly the layout bug
    // this compacts for: less decorative chrome while typing means less to
    // scroll past to reach it, on top of the explicit scroll-into-view in
    // _PracticeScreenState.
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final loosePadding = keyboardOpen ? AppSpacing.sm : AppSpacing.lg;
    final fieldGap = keyboardOpen ? AppSpacing.md : AppSpacing.xl;
    final feedbackGap = keyboardOpen ? AppSpacing.sm : AppSpacing.lg;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: loosePadding),
                  child: Column(
                    mainAxisAlignment: keyboardOpen
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      AnimatedSize(
                        duration: AppMotion.medium,
                        curve: AppMotion.standard,
                        child: AnimatedSwitcher(
                          duration: AppMotion.medium,
                          child: keyboardOpen
                              ? Padding(
                                  key: const ValueKey('audio-compact'),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppSpacing.sm,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      PlayButton(onPlay: onPlayAudio, size: 56),
                                      const SizedBox(width: AppSpacing.md),
                                      const AccentQuickSwitch(),
                                    ],
                                  ),
                                )
                              : Column(
                                  key: const ValueKey('audio-full'),
                                  children: [
                                    Text(
                                      'Word ${state.wordsCompletedThisSession + 1} '
                                      'this session',
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                    const SizedBox(height: AppSpacing.xl),
                                    PlayButton(onPlay: onPlayAudio),
                                    const SizedBox(height: AppSpacing.md),
                                    const AccentQuickSwitch(),
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(height: fieldGap),
                      AppShake(
                        trigger: shakeTrigger,
                        child: answerFieldStyle == AnswerFieldStyle.letterBoxes
                            ? PracticeLetterInput(
                                controller: controller,
                                focusNode: focusNode,
                                length: state.word.headword.length,
                                result: state.result,
                                enabled: !_isDone,
                                onChanged: onLetterChanged,
                                onSubmitted: (_) => onCheck(),
                              )
                            : PracticePlainTextField(
                                controller: controller,
                                focusNode: focusNode,
                                length: state.word.headword.length,
                                result: state.result,
                                enabled: !_isDone,
                                onChanged: onLetterChanged,
                                onSubmitted: (_) => onCheck(),
                              ),
                      ),
                      SizedBox(height: feedbackGap),
                      Semantics(
                        key: feedbackKey,
                        liveRegion: true,
                        child: _FeedbackArea(
                          state: state,
                          onCheck: onCheck,
                          onReveal: onReveal,
                          onNext: onNext,
                          onExplain: () => context.push(
                            AppRoutes.wordDetailPath(state.word.id),
                          ),
                          onMarkMastered: onMarkMastered,
                          onUnmarkMastered: onUnmarkMastered,
                        ),
                      ),
                      // Keeps the feedback area reachable by scroll even in
                      // the worst case (long word + small screen): without
                      // this trailing space, the scrollable range can end
                      // exactly at the bottom of the content, leaving no
                      // room to actually scroll the last bit out from under
                      // the keyboard.
                      if (keyboardOpen)
                        SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FeedbackArea extends StatelessWidget {
  const _FeedbackArea({
    required this.state,
    required this.onCheck,
    required this.onReveal,
    required this.onNext,
    required this.onExplain,
    required this.onMarkMastered,
    required this.onUnmarkMastered,
  });

  final PracticeState state;
  final VoidCallback onCheck;
  final VoidCallback onReveal;
  final VoidCallback onNext;
  final VoidCallback onExplain;
  final VoidCallback onMarkMastered;
  final VoidCallback onUnmarkMastered;

  @override
  Widget build(BuildContext context) {
    switch (state.result) {
      case CheckResult.correct:
        return _ResultBanner(
          key: ValueKey('correct-${state.word.id}'),
          success: true,
          icon: Icons.check_circle_rounded,
          title: 'Correct!',
          word: state.word,
          onNext: onNext,
          onExplain: onExplain,
          isMastered: state.justMarkedMastered,
          onMarkMastered: onMarkMastered,
          onUnmarkMastered: onUnmarkMastered,
        );
      case CheckResult.incorrect:
        if (state.isRevealed) {
          return _ResultBanner(
            key: ValueKey('revealed-${state.word.id}'),
            success: false,
            icon: Icons.menu_book_rounded,
            title: 'The word was',
            word: state.word,
            onNext: onNext,
            onExplain: onExplain,
            isMastered: state.justMarkedMastered,
            onMarkMastered: onMarkMastered,
            onUnmarkMastered: onUnmarkMastered,
          );
        }
        return Column(
          key: const ValueKey('incorrect'),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.close_rounded, color: Theme.of(context).colorScheme.error, size: 20),
                const SizedBox(width: 6),
                Text(
                  'Not quite — try again',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                AppButton(
                  label: 'Check',
                  icon: Icons.check_rounded,
                  onPressed: onCheck,
                ),
                AppButton(
                  label: 'Reveal answer',
                  variant: AppButtonVariant.outlined,
                  onPressed: onReveal,
                ),
              ],
            ),
          ],
        );
      case CheckResult.none:
        return Column(
          key: const ValueKey('none'),
          children: [
            AppButton(
              label: 'Check',
              icon: Icons.check_rounded,
              variant: AppButtonVariant.gradient,
              onPressed: onCheck,
            ),
          ],
        );
    }
  }
}

class _ResultBanner extends StatelessWidget {
  const _ResultBanner({
    required this.success,
    required this.icon,
    required this.title,
    required this.word,
    required this.onNext,
    required this.onExplain,
    required this.isMastered,
    required this.onMarkMastered,
    required this.onUnmarkMastered,
    super.key,
  });

  final bool success;
  final IconData icon;
  final String title;
  final Word word;
  final VoidCallback onNext;
  final VoidCallback onExplain;
  final bool isMastered;
  final VoidCallback onMarkMastered;
  final VoidCallback onUnmarkMastered;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color =
        success ? context.semanticColors.success : theme.colorScheme.error;

    return Column(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: AppMotion.medium,
          curve: AppMotion.emphasized,
          builder: (context, value, child) => Transform.scale(scale: value, child: child),
          child: Icon(icon, color: color, size: 56),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(color: color),
        ),
        const SizedBox(height: 2),
        Text(word.headword, style: theme.textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          label: 'Continue',
          icon: Icons.arrow_forward_rounded,
          variant: AppButtonVariant.gradient,
          onPressed: onNext,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: 'Explain word',
          variant: AppButtonVariant.text,
          onPressed: onExplain,
        ),
        const SizedBox(height: AppSpacing.sm),
        if (isMastered)
          Tooltip(
            message: 'Tap to remove from Mastered Words',
            child: AppButton(
              label: 'Mastered',
              icon: Icons.star_rounded,
              variant: AppButtonVariant.filled,
              onPressed: onUnmarkMastered,
            ),
          )
        else
          AppButton(
            label: 'Mark as Mastered',
            icon: Icons.star_outline_rounded,
            variant: AppButtonVariant.outlined,
            onPressed: onMarkMastered,
          ),
      ],
    );
  }
}
