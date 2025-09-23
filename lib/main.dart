
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pennypath/providers/auth_provider.dart';
import 'package:pennypath/providers/category_provider.dart';
import 'package:pennypath/providers/expense_provider.dart';
import 'package:pennypath/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PennyPath',
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            surface: const Color(0xFFF5F5F5),
            onSurface: const Color(0xFF212121),
            primary: const Color(0xFF0D47A1),
            onPrimary: Colors.white,
            secondary: const Color(0xFFFF6D00),
            tertiary: const Color(0xFF00BFA5),
            outline: const Color(0xFFBDBDBD),
          ),
          textTheme: GoogleFonts.latoTextTheme(),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}