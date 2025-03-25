class Failure implements Exception {
  final String message;
  final FailureType type;

  const Failure({
    required this.message,
    required this.type,
  });
}

enum FailureType { api, validation, notFound, network, unknown }
