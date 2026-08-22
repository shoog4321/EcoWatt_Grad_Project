import 'package:flutter/material.dart';
import '../widgets/ecowatt_widgets.dart';
import 'main_screen.dart';
import 'package:flutter_application_1/user_storage.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

void _login() async {
  if (_formKey.currentState!.validate()) {
    final email = emailController.text.trim();

    final user = await UserStorage.getUser(email);

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No account found')),
      );
      return;
    }

    await UserStorage.saveCurrentUser(email); // 👈 هذا الحل

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return EcowattScaffold(
      showBack: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset('assets/images/logo.png', width: 80, height: 80),
              const SizedBox(height: 16),
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ecowattDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Log in to continue tracking your energy',
                style: TextStyle(color: ecowattText),
              ),
              const SizedBox(height: 32),

              EcowattTextField(
                label: 'Email',
                hint: 'your.email@example.com',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$')
                      .hasMatch(value.trim())) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              EcowattTextField(
                label: 'Password',
                hint: 'Enter your password',
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              EcowattButton(
                text: 'Log In',
                onPressed: _login,
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: ecowattText,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        color: ecowattGreen,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}