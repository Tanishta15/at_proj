import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/download.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 280,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.brown.shade100.withOpacity(0.8),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif',
                    ),
                  ),
                  SizedBox(height: 12),
                  buildInputField("username", usernameController),
                  buildInputField("DOB", dobController),
                  buildInputField("email", emailController),
                  buildInputField("password", passwordController, obscureText: true),
                  buildInputField("confirm password", confirmPasswordController, obscureText: true),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Back to login
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                      child: Text("Sign up →"),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildInputField(String hint, TextEditingController controller, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.orange.shade100.withOpacity(0.6),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}