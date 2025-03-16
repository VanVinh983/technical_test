import 'package:flutter_test/flutter_test.dart';
import 'package:technical_test/services/authentication_service.dart';

void main() {
  group('Authentication Module - Unit Tests', () {
    final authService = AuthenticationService();

    test('Login with valid credentials', () async {
      expect(await authService.login('doanvinh@gmail.com', 'password123'), 'Token123');
    });

    test('Login with invalid credentials throws error', () {
      expect(authService.login('invalid@example.com', 'wrongpassword'), throwsException);
    });

    test('Login with empty email or password throws error', () {
      expect(authService.login('', 'password123'), throwsException);
      expect(authService.login('doanvinh@gmail.com', ''), throwsException);
    });
  });
}
