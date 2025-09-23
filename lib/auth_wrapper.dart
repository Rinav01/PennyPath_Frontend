
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pennypath/providers/auth_provider.dart';
import 'package:pennypath/app_view.dart';
import 'package:pennypath/screens/login/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        if (auth.authState == AuthState.authenticated) {
          return const MyAppView();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
