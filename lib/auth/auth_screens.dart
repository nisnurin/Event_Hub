import 'package:flutter/material.dart';
import '../main.dart';
import '../home/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController(
    text: 'franklinclinton@gmail.com',
  );
  final TextEditingController _passController = TextEditingController(
    text: 'password123',
  );
  String _selectedRole = 'Student';

  void _handleLogin() {
    final db = DatabaseProvider.of(context);
    final success = db.signIn(_emailController.text, _passController.text);
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid User Records')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Sign in to\nyour account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                children: [
                  ChoiceChip(
                    label: const Text('Staff'),
                    selected: _selectedRole == 'Staff',
                    onSelected: (_) => setState(() => _selectedRole = 'Staff'),
                  ),
                  ChoiceChip(
                    label: const Text('Student'),
                    selected: _selectedRole == 'Student',
                    onSelected: (_) =>
                        setState(() => _selectedRole = 'Student'),
                  ),
                ],
              ),
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  hintText: 'Enter your email',
                  hintStyle: const TextStyle(color: Colors.black38),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passController,
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.black38),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9D4EDD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _handleLogin,
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
