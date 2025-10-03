import 'package:flutter/material.dart';
import 'package:pennypath/models/auth_state.dart';
import 'package:pennypath/viewmodels/auth/auth_viewmodel.dart';
import 'package:pennypath/views/screens/home/home_screen.dart';
import 'package:pennypath/views/screens/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:pennypath/views/screens/loader_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building AuthWrapper");
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        switch (authViewModel.authState) {
          case AuthState.checkingFirstLaunch:
            return const LoaderScreen();
          case AuthState.authenticated:
            return HomeScreen();
          case AuthState.unauthenticated:
          case AuthState.error:
            return const LoginScreen();
          case AuthState.authenticating:
          default:
            return const LoaderScreen();
        }
      },
    );
  }
}