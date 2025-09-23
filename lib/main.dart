import 'package:flutter/material.dart';
import 'package:pennypath/app.dart';
import 'package:provider/provider.dart';
import 'package:pennypath/providers/auth_provider.dart';
import 'package:pennypath/providers/category_provider.dart';
import 'package:pennypath/providers/expense_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, CategoryProvider>(
          create: (context) => CategoryProvider(context.read<AuthProvider>()),
          update: (context, auth, previous) => CategoryProvider(auth),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ExpenseProvider>(
          create: (context) => ExpenseProvider(context.read<AuthProvider>()),
          update: (context, auth, previous) => ExpenseProvider(auth),
        ),
      ],
      child: const MyApp(),
    ),
  );
}