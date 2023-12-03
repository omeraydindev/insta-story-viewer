class Result<T> {
  final T? data;
  final bool hasError;
  final String errorMessage;

  Result({this.data, this.hasError = false, this.errorMessage = ''});

  factory Result.success(T data) {
    return Result(data: data);
  }

  factory Result.failure(String errorMessage) {
    return Result(hasError: true, errorMessage: errorMessage);
  }
}
