class WrongCredentialsError implements Exception {
  final String message;

  WrongCredentialsError([this.message = 'Credenciales incorrectas']);

  @override
  String toString() => 'WrongCredentialsError: $message';
}

class InvalidToken implements Exception {
  final String message;

  InvalidToken([this.message = 'Token inválido']);

  @override
  String toString() => 'InvalidToken: $message';
}
