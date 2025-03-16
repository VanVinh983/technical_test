import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:technical_test/main.dart';
import 'package:technical_test/services/authentication_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Authentication Module - Integration Tests', () {
    testWidgets('Complete login process and verify token', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      // Enter credentials
      await tester.enterText(find.byType(TextField).at(0), 'doanvinh@gmail.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify home screen is displayed
      expect(find.text('Home Screen'), findsOneWidget);

      // Verify token is returned
      final authService = AuthenticationService();
      final token = await authService.login('doanvinh@gmail.com', 'password123');
      expect(token, 'Token123');
    });

    testWidgets('Login with invalid credentials shows error', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      // Enter invalid credentials
      await tester.enterText(find.byType(TextField).at(0), 'invalid@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'wrongpassword');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify error message is displayed
      expect(find.text('Exception: Login Failed'), findsOneWidget);
    });
  });
}
