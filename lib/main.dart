import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pennypath/app.dart';
import 'package:provider/provider.dart';
import 'package:pennypath/viewmodels/auth/auth_viewmodel.dart';
import 'package:pennypath/viewmodels/category/category_viewmodel.dart';
import 'package:pennypath/viewmodels/expense/expense_viewmodel.dart';
import 'package:pennypath/viewmodels/loading_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final loadingViewModel = LoadingViewModel();
  final authViewModel = AuthViewModel(loadingViewModel);

  final categoryViewModel = CategoryViewModel(authViewModel);
  final expenseViewModel = ExpenseViewModel(authViewModel, loadingViewModel);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authViewModel),
        ChangeNotifierProvider.value(value: categoryViewModel),
        ChangeNotifierProvider.value(value: expenseViewModel),
        ChangeNotifierProvider.value(value: loadingViewModel),
      ],
      child: const MyApp(),
    ),
  );
}