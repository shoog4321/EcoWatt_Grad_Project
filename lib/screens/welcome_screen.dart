import 'package:flutter/material.dart';
import '../widgets/ecowatt_widgets.dart';
import 'create_account_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFF0FDF4)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const Spacer(),
                Image.asset('assets/images/logo.png', width: 128, height: 128, errorBuilder: (_, __, ___) {
                  return const Icon(Icons.energy_savings_leaf, size: 96, color: ecowattGreen);
                }),
                const SizedBox(height: 32),
                const Text('Welcome to Ecowatt', textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: ecowattDark)),
                const SizedBox(height: 12),
                const Text('Your smart electricity consumption companion for Saudi households', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, height: 1.5, color: ecowattGray)),
                const SizedBox(height: 44),
                const _FeatureRow(text: 'Understand your electricity bills easily'),
                const SizedBox(height: 16),
                const _FeatureRow(text: 'Track consumption patterns'),
                const SizedBox(height: 16),
                const _FeatureRow(text: 'Get AI-powered energy insights'),
                const Spacer(),
                EcowattButton(
                  text: 'Create Account',
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateAccountScreen())),
                ),
                const SizedBox(height: 12),
                EcowattButton(
  text: 'Log In',
  outlined: true, 
  onPressed: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const LoginScreen()),
  ),
),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(color: ecowattGreen, shape: BoxShape.circle),
          child: const Icon(Icons.check, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 16, color: Color(0xFF364153)))),
      ],
    );
  }
}
