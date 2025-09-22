
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pennypath/screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          surface: const Color(0xFFF5F5F5),
          onSurface: const Color(0xFF212121),
          primary: const Color(0xFF0D47A1),
          onPrimary: Colors.white,
          secondary: const Color(0xFFFF6D00),
          tertiary: const Color(0xFF00BFA5),
          outline: const Color(0xFFBDBDBD),
        ),
        textTheme: GoogleFonts.latoTextTheme(), // This now works
      ),
      home: const HomeScreen(),
    ); 
  }
}
