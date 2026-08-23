import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_semantic_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_progress_bar.dart';
import '../../../core/widgets/app_reveal.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_shake.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../practice/application/answer_field_style.dart';
import '../../practice/application/answer_field_style_controller.dart';
import '../../practice/application/check_result.dart';
import '../../practice/presentation/widgets/accent_quick_switch.dart';
import '../../practice/presentation/widgets/practice_letter_input.dart';
import '../../practice/presentation/widgets/practice_plain_text_field.dart';
import '../../practice/presentation/widgets/practice_play_button.dart';
import '../application/mastered_review_controller.dart';
import '../application/mastered_review_state.dart';

const _autoPlayDelay = Duration(milliseconds: 650);

class MasteredReviewScreen extends ConsumerStatefulWidget {
  const MasteredReviewScreen({super.key});

  @override
  ConsumerState<MasteredReviewScreen> createState() => _MasteredReviewScreenState();
}

class _MasteredReviewScreenState extends ConsumerState<MasteredReviewScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
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

  void _scrollFeedbackIntoView() {
    Future.delayed(const Duration(milliseconds: 280), () {
      if (!mounted) return;
      final feedbackContext = _feedbackKey.currentContext;
      if (feedbackContext == null) return;
      Scrollable.ensureVisible(
        // ignore: use_build_context_synchronously
        feedbackContext,
        duration: AppMotion.medium,
        curve: AppMotion.standard,
        alignment: 1,
      );
    });
  }

  void _onReviewStateChange(
    AsyncValue<MasteredReviewState>? previous,
    AsyncValue<MasteredReviewState> next,
  ) {
    final previousWordId = previous?.valueOrNull?.currentWord?.id;
    final nextWord = next.valueOrNull?.currentWord;
    if (nextWord == null || nextWord.id == previousWordId) return;

    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer(_autoPlayDelay, () {
      if (!mounted) return;
      ref.read(masteredReviewControllerProvider.notifier).playAudio();
    });
  }

  Future<void> _check() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final correct = await ref
        .read(masteredReviewControllerProvider.notifier)
        .checkAnswer(text);
    if (!correct) setState(() => _shakeTrigger++);
    _scrollFeedbackIntoView();
  }

  void _onLetterChanged(String _) {
    ref.read(masteredReviewControllerProvider.notifier).retry();
  }

  void _advance(void Function() action) {
    _controller.clear();
    action();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final stateAsync = ref.watch(masteredReviewControllerProvider);
    ref.listen<AsyncValue<MasteredReviewState>>(
      masteredReviewControllerProvider,
      _onReviewStateChange,
    );
    final answerFieldStyle = ref.watch(answerFieldStyleControllerProvider);
    final notifier = ref.read(masteredReviewControllerProvider.notifier);

    return AppScaffold(
      title: 'Mastered Review',
      body: stateAsync.when(
        loading: () => const LoadingIndicator(message: 'Gathering mastered words…'),
        error: (error, stackTrace) => EmptyState(
          icon: Icons.star_outline_rounded,
          message: 'No mastered words to review yet.',
        ),
        data: (state) => state.isComplete
            ? _ReviewCompleteContent(state: state)
            : _ReviewingContent(
                state: state,
                controller: _controller,
                focusNode: _focusNode,
                feedbackKey: _feedbackKey,
                shakeTrigger: _shakeTrigger,
                answerFieldStyle: answerFieldStyle,
                onCheck: _check,
                onLetterChanged: _onLetterChanged,
                onPlayAudio: notifier.playAudio,
                onNext: () => _advance(notifier.nextWord),
                onKeepMastered: () => _advance(notifier.keepMastered),
                onRemoveFromMastered: () => _advance(notifier.removeFromMastered),
                onContinueAfterAutoRemoval: () =>
                    _advance(notifier.continueAfterAutoRemoval),
              ),
      ),
    );
  }
}

class _ReviewingContent extends StatelessWidget {
  const _ReviewingContent({
    required this.state,
    required this.controller,
    required this.focusNode,
    required this.feedbackKey,
    required this.shakeTrigger,
    required this.answerFieldStyle,
    required this.onCheck,
    required this.onLetterChanged,
    required this.onPlayAudio,
    required this.onNext,
    required this.onKeepMastered,
    required this.onRemoveFromMastered,
    required this.onContinueAfterAutoRemoval,
  });

  final MasteredReviewState state;
  final TextEditingController controller;
  final FocusNode focusNode;
  final GlobalKey feedbackKey;
  final int shakeTrigger;
  final AnswerFieldStyle answerFieldStyle;
  final VoidCallback onCheck;
  final ValueChanged<String> onLetterChanged;
  final VoidCallback onPlayAudio;
  final VoidCallback onNext;
  final VoidCallback onKeepMastered;
  final VoidCallback onRemoveFromMastered;
  final VoidCallback onContinueAfterAutoRemoval;

  bool get _isDone => state.result == CheckResult.correct || state.justAutoRemoved;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final word = state.currentWord;
    if (word == null) return const SizedBox.shrink();

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
                    mainAxisAlignment:
                        keyboardOpen ? MainAxisAlignment.start : MainAxisAlignment.center,
                    children: [
                      Text(
                        'Reviewing Mastered Words',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '${state.currentPosition} / ${state.totalWordsAtStart}',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      AppProgressBar(
                        progress: (state.reviewedCount) / state.totalWordsAtStart,
                      ),
                      SizedBox(height: keyboardOpen ? AppSpacing.sm : AppSpacing.lg),
                      if (!keyboardOpen) ...[
                        PlayButton(onPlay: onPlayAudio),
                        const SizedBox(height: AppSpacing.md),
                      ] else ...[
                        PlayButton(onPlay: onPlayAudio, size: 56),
                        const SizedBox(height: AppSpacing.sm),
                      ],
                      const AccentQuickSwitch(),
                      SizedBox(height: fieldGap),
                      AppShake(
                        trigger: shakeTrigger,
                        child: answerFieldStyle == AnswerFieldStyle.letterBoxes
                            ? PracticeLetterInput(
                                controller: controller,
                                focusNode: focusNode,
                                length: word.headword.length,
                                result: state.result,
                                enabled: !_isDone,
                                onChanged: onLetterChanged,
                                onSubmitted: (_) => onCheck(),
                              )
                            : PracticePlainTextField(
                                controller: controller,
                                focusNode: focusNode,
                                length: word.headword.length,
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
                        child: _ReviewFeedbackArea(
                          state: state,
                          word: word.headword,
                          onCheck: onCheck,
                          onNext: onNext,
                          onKeepMastered: onKeepMastered,
                          onRemoveFromMastered: onRemoveFromMastered,
                          onContinueAfterAutoRemoval: onContinueAfterAutoRemoval,
                        ),
                      ),
                      if (keyboardOpen)
                        SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
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

class _ReviewFeedbackArea extends StatelessWidget {
  const _ReviewFeedbackArea({
    required this.state,
    required this.word,
    required this.onCheck,
    required this.onNext,
    required this.onKeepMastered,
    required this.onRemoveFromMastered,
    required this.onContinueAfterAutoRemoval,
  });

  final MasteredReviewState state;
  final String word;
  final VoidCallback onCheck;
  final VoidCallback onNext;
  final VoidCallback onKeepMastered;
  final VoidCallback onRemoveFromMastered;
  final VoidCallback onContinueAfterAutoRemoval;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    switch (state.result) {
      case CheckResult.correct:
        return Column(
          key: ValueKey('correct-$word'),
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: AppMotion.medium,
              curve: AppMotion.emphasized,
              builder: (context, value, child) =>
                  Transform.scale(scale: value, child: child),
              child: Icon(
                Icons.check_circle_rounded,
                color: context.semanticColors.success,
                size: 56,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Correct!',
              style: theme.textTheme.titleMedium
                  ?.copyWith(color: context.semanticColors.success),
            ),
            const SizedBox(height: 2),
            Text(word, style: theme.textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Continue',
              icon: Icons.arrow_forward_rounded,
              variant: AppButtonVariant.gradient,
              onPressed: onNext,
            ),
          ],
        );
      case CheckResult.incorrect:
        if (state.justAutoRemoved) {
          return Column(
            key: ValueKey('auto-removed-$word'),
            children: [
              Icon(Icons.undo_rounded, color: theme.colorScheme.error, size: 40),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'This word needs more practice.',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: theme.colorScheme.error),
              ),
              const SizedBox(height: 2),
              Text(
                '↩ Returned to Practice',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: 'Continue',
                icon: Icons.arrow_forward_rounded,
                variant: AppButtonVariant.gradient,
                onPressed: onContinueAfterAutoRemoval,
              ),
            ],
          );
        }
        return Column(
          key: const ValueKey('incorrect'),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.close_rounded, color: theme.colorScheme.error, size: 20),
                const SizedBox(width: 6),
                Text(
                  'Not quite — attempt ${state.failuresThisWord} of 3',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: theme.colorScheme.error),
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
                  label: 'Try Again',
                  icon: Icons.check_rounded,
                  onPressed: onCheck,
                ),
                AppButton(
                  label: 'Keep Mastered',
                  variant: AppButtonVariant.outlined,
                  onPressed: onKeepMastered,
                ),
                AppButton(
                  label: 'Remove from Mastered',
                  variant: AppButtonVariant.text,
                  onPressed: onRemoveFromMastered,
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

class _ReviewCompleteContent extends StatelessWidget {
  const _ReviewCompleteContent({required this.state});

  final MasteredReviewState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accuracy = state.totalWordsAtStart == 0
        ? 0.0
        : state.successCount / state.totalWordsAtStart;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppReveal(
                index: 0,
                child: Icon(
                  Icons.star_rounded,
                  color: theme.colorScheme.primary,
                  size: 48,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppReveal(
                index: 1,
                child: Text(
                  'Mastered Review Complete',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              AppReveal(
                index: 1,
                child: Text(
                  '${state.totalWordsAtStart} '
                  '${state.totalWordsAtStart == 1 ? 'word' : 'words'} reviewed',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppReveal(
                index: 2,
                child: Column(
                  children: [
                    _SummaryRow(
                      icon: Icons.check_circle_outline,
                      color: context.semanticColors.success,
                      label: 'Remembered',
                      value: '${state.successCount}',
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _SummaryRow(
                      icon: Icons.undo_rounded,
                      color: theme.colorScheme.error,
                      label: 'Returned to practice',
                      value: '${state.returnedToPracticeCount}',
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _SummaryRow(
                      icon: Icons.close_rounded,
                      color: theme.colorScheme.onSurfaceVariant,
                      label: 'Total mistakes',
                      value: '${state.totalMistakes}',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppReveal(
                index: 3,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Accuracy', style: theme.textTheme.labelLarge),
                        Text(
                          '${(accuracy * 100).round()}%',
                          style: theme.textTheme.labelLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    AppProgressBar(progress: accuracy),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              AppReveal(
                index: 4,
                child: AppButton(
                  label: 'Done',
                  variant: AppButtonVariant.gradient,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(label, style: theme.textTheme.bodyLarge)),
        Text(value, style: theme.textTheme.titleMedium),
      ],
    );
  }
}
