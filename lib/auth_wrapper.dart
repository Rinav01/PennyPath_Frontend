import 'package:flutter/material.dart';
import 'package:pennypath/models/auth_state.dart';
import 'package:pennypath/viewmodels/auth/auth_viewmodel.dart';
import 'package:pennypath/views/screens/home/home_screen.dart';
import 'package:pennypath/views/screens/login/login_screen.dart';
import 'package:pennypath/views/screens/login/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    switch (authViewModel.authState) {
      case AuthState.authenticated:
        return const HomeScreen();
      case AuthState.unauthenticated:
      case AuthState.error:
        return const LoginScreen();
      case AuthState.authenticating:
      default:
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
    }
  }
}