import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:technical_test/services/authentication_service.dart';
import 'package:technical_test/views/login_screen.dart';
void main() {
  group('Authentication Module - Widget Tests', () {
    testWidgets('Displays error message on failed login', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen(authService: AuthenticationService())));
      await tester.enterText(find.byType(TextField).first, 'user@example.com');
      await tester.enterText(find.byType(TextField).last, 'wrongpassword');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Exception: Login Failed'), findsOneWidget);
    });

    testWidgets('Successful login navigates to home screen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen(authService: AuthenticationService())));
      await tester.enterText(find.byType(TextField).first, 'doanvinh@gmail.com');
      await tester.enterText(find.byType(TextField).last, 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Home Screen'), findsOneWidget);
    });
  });
}
