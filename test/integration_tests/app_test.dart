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

    testWidgets('Login with empty email shows error', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      // Enter empty email
      await tester.enterText(find.byType(TextField).at(0), '');
      await tester.enterText(find.byType(TextField).at(1), 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify error message is displayed
      expect(find.text('Exception: Email or password cannot be empty'), findsOneWidget);
    });

    testWidgets('Login with empty password shows error', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      // Enter empty password
      await tester.enterText(find.byType(TextField).at(0), 'doanvinh@gmail.com');
      await tester.enterText(find.byType(TextField).at(1), '');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify error message is displayed
      expect(find.text('Exception: Email or password cannot be empty'), findsOneWidget);
    });

    testWidgets('Login with invalid email format shows error', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      // Enter invalid email format
      await tester.enterText(find.byType(TextField).at(0), 'invalid-email');
      await tester.enterText(find.byType(TextField).at(1), 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify error message is displayed
      expect(find.text('Exception: Invalid email format'), findsOneWidget);
    });

    testWidgets('Login with short password shows error', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      // Enter short password
      await tester.enterText(find.byType(TextField).at(0), 'doanvinh@gmail.com');
      await tester.enterText(find.byType(TextField).at(1), 'short');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify error message is displayed
      expect(find.text('Exception: Password must be at least 6 characters long'), findsOneWidget);
    });

    testWidgets('Login with correct email but incorrect password shows error', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      // Enter correct email but incorrect password
      await tester.enterText(find.byType(TextField).at(0), 'doanvinh@gmail.com');
      await tester.enterText(find.byType(TextField).at(1), 'wrongpassword');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify error message is displayed
      expect(find.text('Exception: Incorrect password'), findsOneWidget);
    });

    testWidgets('Login with incorrect email but correct password shows error', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      // Enter incorrect email but correct password
      await tester.enterText(find.byType(TextField).at(0), 'wrongemail@gmail.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify error message is displayed
      expect(find.text('Exception: Email not found'), findsOneWidget);
    });
  });
}
