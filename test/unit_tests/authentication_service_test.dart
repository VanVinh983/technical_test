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

    test('Login with invalid email format throws error', () {
      expect(authService.login('invalid-email', 'password123'), throwsException);
    });

    test('Login with short password throws error', () {
      expect(authService.login('doanvinh@gmail.com', 'short'), throwsException);
    });

    test('Login with correct email but incorrect password throws error', () {
      expect(authService.login('doanvinh@gmail.com', 'wrongpassword'), throwsException);
    });

    test('Login with incorrect email but correct password throws error', () {
      expect(authService.login('wrongemail@gmail.com', 'password123'), throwsException);
    });
  });
}
