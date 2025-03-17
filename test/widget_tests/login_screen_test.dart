import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:technical_test/services/authentication_service.dart';
import 'package:technical_test/views/login_screen.dart';

void main() {
  group('Authentication Module - Widget Tests', () {
    testWidgets('Successful login navigates to home screen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen(authService: AuthenticationService())));
      await tester.enterText(find.byType(TextField).first, 'doanvinh@gmail.com');
      await tester.enterText(find.byType(TextField).last, 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Home Screen'), findsOneWidget);
    });

    testWidgets('Displays error message on empty email', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen(authService: AuthenticationService())));
      await tester.enterText(find.byType(TextField).first, '');
      await tester.enterText(find.byType(TextField).last, 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Exception: Email or password cannot be empty'), findsOneWidget);
    });

    testWidgets('Displays error message on empty password', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen(authService: AuthenticationService())));
      await tester.enterText(find.byType(TextField).first, 'doanvinh@gmail.com');
      await tester.enterText(find.byType(TextField).last, '');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Exception: Email or password cannot be empty'), findsOneWidget);
    });

    testWidgets('Displays error message on invalid email format', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen(authService: AuthenticationService())));
      await tester.enterText(find.byType(TextField).first, 'invalid-email');
      await tester.enterText(find.byType(TextField).last, 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Exception: Invalid email format'), findsOneWidget);
    });

    testWidgets('Displays error message on short password', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen(authService: AuthenticationService())));
      await tester.enterText(find.byType(TextField).first, 'doanvinh@gmail.com');
      await tester.enterText(find.byType(TextField).last, 'short');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Exception: Password must be at least 6 characters long'), findsOneWidget);
    });

    testWidgets('Displays error message on incorrect password', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen(authService: AuthenticationService())));
      await tester.enterText(find.byType(TextField).first, 'doanvinh@gmail.com');
      await tester.enterText(find.byType(TextField).last, 'wrongpassword');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Exception: Incorrect password'), findsOneWidget);
    });

    testWidgets('Displays error message on email not found', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen(authService: AuthenticationService())));
      await tester.enterText(find.byType(TextField).first, 'wrongemail@gmail.com');
      await tester.enterText(find.byType(TextField).last, 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Exception: Email not found'), findsOneWidget);
    });
  });
}
