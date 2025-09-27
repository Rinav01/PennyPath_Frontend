import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pennypath/app.dart';
import 'package:provider/provider.dart';
import 'package:pennypath/viewmodels/auth/auth_viewmodel.dart';
import 'package:pennypath/viewmodels/category/category_viewmodel.dart';
import 'package:pennypath/viewmodels/expense/expense_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
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
}