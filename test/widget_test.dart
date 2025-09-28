// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pennypath/app.dart';
import 'package:pennypath/viewmodels/auth/auth_viewmodel.dart';
import 'package:pennypath/viewmodels/category/category_viewmodel.dart';
import 'package:pennypath/viewmodels/expense/expense_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Renders LoginScreen when not authenticated', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProxyProvider<AuthViewModel, CategoryViewModel>(
            create: (context) => CategoryViewModel(context.read<AuthViewModel>()),
            update: (context, auth, previous) => CategoryViewModel(auth),
          ),
          ChangeNotifierProxyProvider<AuthViewModel, ExpenseViewModel>(
            create: (context) => ExpenseViewModel(context.read<AuthViewModel>()),
            update: (context, auth, previous) => ExpenseViewModel(auth),
          ),
        ],
        child: const MyApp(),
      ),
    );

    // The first frame is a loading indicator.
    await tester.pumpAndSettle();
    await tester.pump(Duration.zero);

    // Verify that the login screen is rendered.
    expect(find.text('Welcome to PennyPath'), findsOneWidget);
  });
}
