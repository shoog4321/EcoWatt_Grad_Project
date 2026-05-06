import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const EcowattApp());
}

class EcowattApp extends StatelessWidget {
  const EcowattApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecowatt',
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF08A045),
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}