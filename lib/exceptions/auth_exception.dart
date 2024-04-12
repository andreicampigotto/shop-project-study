class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'E-mail alread exists',
    'OPERATION_NOT_ALLOWED': 'Operation not allowed',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Access denied. Too many attempts',
    'EMAIL_NOT_FOUND': 'E-mail not found',
    'INVALID_LOGIN_CREDENTIALS': 'Invalid e-mail or password.',
    'INVALID_PASSWORD': 'Invalid e-mail or password.',
    'USER_DISABLED': 'User is disabled.',
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'An error has occurred';
  }
}
