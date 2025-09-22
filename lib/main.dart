
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pennypath/providers/auth_provider.dart';
import 'package:pennypath/providers/category_provider.dart';
import 'package:pennypath/providers/expense_provider.dart';
import 'package:pennypath/app_view.dart';
import 'package:pennypath/screens/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return MaterialApp(
            title: 'PennyPath',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: auth.authState == AuthState.authenticated
                ? const MyAppView()
                : const LoginScreen(),
          );
        },
      ),
    );
  }
}