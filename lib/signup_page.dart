import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _dobController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _handleSignUp() async {
    setState(() {
      _isLoading = true;
    });

    final username = _usernameController.text.trim();
    final dob = _dobController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // ✅ Ensure 'message' always has a value
    String message = "Unknown error occurred.";

    if (password != confirmPassword) {
      message = "Passwords do not match";
      _showDialogAndRedirect(message);
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'dob': dob,
        'email': email,
      });

      message = "Sign-up successful!";
    } on FirebaseAuthException catch (e) {
      message = _getErrorMessage(e.code);
    } finally {
      setState(() {
        _isLoading = false;
      });

      // ✅ Show dialog and always redirect to dashboard after clicking OK
      _showDialogAndRedirect(message);
    }
  }

  void _showDialogAndRedirect(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sign Up"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pushReplacementNamed(context, '/dashboard'); // Redirect to dashboard
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'Email is already registered.';
      case 'weak-password':
        return 'Password should be at least 6 characters.';
      case 'invalid-email':
        return 'Invalid email format.';
      default:
        return 'Sign-up failed. Please try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _usernameController, decoration: const InputDecoration(labelText: 'Username')),
            TextField(controller: _dobController, decoration: const InputDecoration(labelText: 'Date of Birth')),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            TextField(controller: _confirmPasswordController, decoration: const InputDecoration(labelText: 'Confirm Password'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _handleSignUp,
              child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
