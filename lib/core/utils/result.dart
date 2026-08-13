/// Lightweight success/failure wrapper so repositories can surface errors
/// to the UI layer without throwing across layer boundaries.
sealed class Result<T> {
  const Result();

  factory Result.success(T value) = Success<T>;
  factory Result.failure(Object error, [StackTrace? stackTrace]) =
      Failure<T>;

  R when<R>({
    required R Function(T value) success,
    required R Function(Object error, StackTrace? stackTrace) failure,
  }) {
    final self = this;
    return switch (self) {
      Success<T>() => success(self.value),
      Failure<T>() => failure(self.error, self.stackTrace),
    };
  }
}

final class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
}

final class Failure<T> extends Result<T> {
  const Failure(this.error, [this.stackTrace]);
  final Object error;
  final StackTrace? stackTrace;
}
