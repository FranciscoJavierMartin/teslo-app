import 'package:flutter/material.dart';
import 'package:teslo_app/features/shared/shared.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child:
          Scaffold(body: GeometricalBackground(child: SingleChildScrollView())),
    );
  }
}
