import 'package:flutter/material.dart';
import '../widgets/ecowatt_widgets.dart';
import 'household_information_screen.dart';
import 'login_screen.dart';
class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _continue() {
  if (_formKey.currentState!.validate()) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HouseholdInformationScreen(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
          password: passwordController.text,
        ),
      ),
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
              Image.asset('assets/images/logo.png', width: 80, height: 80),
              const SizedBox(height: 16),
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ecowattDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Join Ecowatt to start tracking your energy',
                style: TextStyle(color: ecowattText),
              ),
              const SizedBox(height: 32),

              EcowattTextField(
  label: 'First Name',
  hint: 'Enter your first name',
  controller: firstNameController,
  validator: (value) {
    if (value == null || value.trim().isEmpty) {
      return 'First name is required';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
      return 'Name must contain letters only';
    }
    return null;
  },
),
const SizedBox(height: 20),

EcowattTextField(
  label: 'Last Name',
  hint: 'Enter your last name',
  controller: lastNameController,
  validator: (value) {
    if (value == null || value.trim().isEmpty) {
      return 'Last name is required';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
      return 'Name must contain letters only';
    }
    return null;
  },
),
const SizedBox(height: 20),

              EcowattTextField(
                label: 'Email',
                hint: 'your.email@example.com',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                   return 'Email is required';
                   }
                  if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(value.trim())) {
                  return 'Enter a valid email';
                   }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              EcowattTextField(
                label: 'Phone Number',
                hint: '+966 5X XXX XXXX',
                controller: phoneController,
                keyboardType: TextInputType.phone,
               validator: (value) {
                if (value == null || value.trim().isEmpty) {
                   return 'Phone number is required';
                  }
                  if (!RegExp(r'^05\d{8}$').hasMatch(value.trim())) {
                   return 'Phone number must be 10 digits and start with 05';
                  }
                  return null;
                  },
              ),
              const SizedBox(height: 20),

              EcowattTextField(
                label: 'Password',
                hint: 'Create a password',
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              EcowattButton(
                text: 'Continue',
                onPressed: _continue,
              ),
              const SizedBox(height: 24),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text(
      'Already have an account? ',
      style: TextStyle(
        color: ecowattText,
        fontSize: 14,
      ),
    ),
    GestureDetector(
      onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const LoginScreen(),
    ),
  );
},
      child: const Text(
        'Log In',
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