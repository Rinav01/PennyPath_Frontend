import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pennypath/models/auth_state.dart';
import 'package:provider/provider.dart';
import 'package:pennypath/viewmodels/auth/auth_viewmodel.dart';
import 'package:pennypath/views/screens/login/forgot_password_screen.dart';
import 'package:pennypath/views/screens/login/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      authViewModel.signup(_nameController.text, _emailController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/piggy_bank.jpg', height: 150),
                  const SizedBox(height: 20),
                  Text(
                    'Welcome to PennyPath',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: colorScheme.onSurface),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: colorScheme.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: colorScheme.primary),
                      ),
                    ),
                    style: TextStyle(color: colorScheme.onSurface),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: colorScheme.onSurface),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: colorScheme.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: colorScheme.primary),
                      ),
                    ),
                    style: TextStyle(color: colorScheme.onSurface),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: colorScheme.onSurface),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: colorScheme.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: colorScheme.primary),
                      ),
                    ),
                    obscureText: true,
                    style: TextStyle(color: colorScheme.onSurface),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Consumer<AuthViewModel>(
                    builder: (context, auth, child) {
                      if (auth.authState == AuthState.authenticating) {
                        return Lottie.asset(
                          'assets/Rupee Coin.json',
                          width: 100,
                          height: 100,
                        );
                      }
                      return ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: colorScheme.onPrimary),
                        ),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'I already have an account',
                      style: TextStyle(color: colorScheme.onSurface),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: colorScheme.onSurface),
                    ),
                  ),
                  Consumer<AuthViewModel>(
                    builder: (context, auth, child) {
                      if (auth.authState == AuthState.error) {
                        return Text(
                          auth.errorMessage ?? 'An error occurred',
                          style: TextStyle(color: colorScheme.error),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
