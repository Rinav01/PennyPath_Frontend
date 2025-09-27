
import 'package:flutter/material.dart';
import 'package:pennypath/models/auth_state.dart';
import 'package:pennypath/viewmodels/auth/auth_viewmodel.dart';
import 'package:pennypath/views/screens/home/home_screen.dart';
import 'package:pennypath/views/screens/login/login_screen.dart';
import 'package:provider/provider.dart';


class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, auth, _) {
        if (auth.authState == AuthState.authenticated) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
