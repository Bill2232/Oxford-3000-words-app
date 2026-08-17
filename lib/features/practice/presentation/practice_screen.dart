import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_semantic_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_shake.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../domain/entities/word.dart';
import '../application/check_result.dart';
import '../application/practice_controller.dart';
import '../application/practice_state.dart';
import 'widgets/practice_letter_input.dart';

class PracticeScreen extends ConsumerStatefulWidget {
  const PracticeScreen({super.key});

  @override
  ConsumerState<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends ConsumerState<PracticeScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  int _shakeTrigger = 0;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _check() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final correct =
        await ref.read(practiceControllerProvider.notifier).checkAnswer(text);
    if (!correct) setState(() => _shakeTrigger++);
  }

  void _reveal() {
    ref.read(practiceControllerProvider.notifier).revealAnswer();
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

  @override
  Widget build(BuildContext context) {
    final stateAsync = ref.watch(practiceControllerProvider);

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
          shakeTrigger: _shakeTrigger,
          onCheck: _check,
          onReveal: _reveal,
          onNext: _next,
          onLetterChanged: _onLetterChanged,
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
    required this.shakeTrigger,
    required this.onCheck,
    required this.onReveal,
    required this.onNext,
    required this.onLetterChanged,
  });

  final PracticeState state;
  final TextEditingController controller;
  final FocusNode focusNode;
  final int shakeTrigger;
  final VoidCallback onCheck;
  final VoidCallback onReveal;
  final VoidCallback onNext;
  final ValueChanged<String> onLetterChanged;

  bool get _isDone =>
      state.result == CheckResult.correct || state.isRevealed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Word ${state.wordsCompletedThisSession + 1} this session',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      _PlayButton(wordId: state.word.id),
                      const SizedBox(height: AppSpacing.xl),
                      AppShake(
                        trigger: shakeTrigger,
                        child: PracticeLetterInput(
                          controller: controller,
                          focusNode: focusNode,
                          length: state.word.headword.length,
                          result: state.result,
                          enabled: !_isDone,
                          onChanged: onLetterChanged,
                          onSubmitted: (_) => onCheck(),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Semantics(
                        liveRegion: true,
                        child: _FeedbackArea(
                          state: state,
                          onCheck: onCheck,
                          onReveal: onReveal,
                          onNext: onNext,
                          onExplain: () => context.push(
                            AppRoutes.wordDetailPath(state.word.id),
                          ),
                        ),
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

class _PlayButton extends ConsumerStatefulWidget {
  const _PlayButton({required this.wordId});

  final int wordId;

  @override
  ConsumerState<_PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends ConsumerState<_PlayButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: 'Play pronunciation',
      child: Semantics(
        button: true,
        label: 'Play pronunciation',
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          onTap: () => ref.read(practiceControllerProvider.notifier).playAudio(),
          child: AnimatedScale(
            scale: _pressed ? 0.94 : 1,
            duration: AppMotion.fast,
            curve: AppMotion.standard,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [scheme.primary, scheme.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: AppShadows.glow(scheme.primary),
              ),
              child: const Icon(Icons.volume_up_rounded, color: Colors.white, size: 40),
            ),
          ),
        ),
      ),
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
  });

  final PracticeState state;
  final VoidCallback onCheck;
  final VoidCallback onReveal;
  final VoidCallback onNext;
  final VoidCallback onExplain;

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
                AppButton(
                  label: 'Explain word',
                  variant: AppButtonVariant.text,
                  onPressed: onExplain,
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
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: 'Explain word',
              variant: AppButtonVariant.text,
              onPressed: onExplain,
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
    super.key,
  });

  final bool success;
  final IconData icon;
  final String title;
  final Word word;
  final VoidCallback onNext;
  final VoidCallback onExplain;

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
      ],
    );
  }
}
