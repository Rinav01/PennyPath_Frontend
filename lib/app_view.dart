import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pennypath/screens/splash_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PennyPath',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Color(0xFFE6FFFA),
          onSurface: const Color(0xFF212121),
          primary: const Color(0xFF0D47A1),
          onPrimary: Colors.white,
          secondary: const Color(0xFFFF6D00),
          tertiary: const Color(0xFF00BFA5),
          outline: const Color(0xFFBDBDBD),
        ),
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          surface: const Color(0xFF212121),
          onSurface: Colors.white,
          primary: const Color(0xFF0D47A1),
          onPrimary: Colors.white,
          secondary: const Color(0xFFFF6D00),
          tertiary: const Color(0xFF00BFA5),
          outline: const Color(0xFFBDBDBD),
        ),
        textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme),
      ),
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
