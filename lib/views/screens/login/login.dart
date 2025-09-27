import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              children: [
                // Top rounded card with custom color and illustration
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFD0ECFE),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  width: double.infinity,
                  height: 320,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/piggy_bank.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 32,
                        left: 28,
                        child: Icon(Icons.currency_rupee_sharp, color: Colors.blueGrey, size: 52),
                      ),
                      Positioned(
                        top: 50,
                        right: 32,
                        child: Icon(Icons.currency_rupee_sharp, color: Colors.blueGrey, size: 48),
                      ),
                      Positioned(
                        top: 28,
                        left: 155,
                        child: Icon(Icons.star, color: Colors.blueGrey, size: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 46),
                // Headline
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Earn rewards for every step you take.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Subhead
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    "More than tracking transform walking into winning.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Log in button
                SizedBox(
                  width: 190,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE6FFFA),
                      foregroundColor: const Color(0xFF212121),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Log in",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
