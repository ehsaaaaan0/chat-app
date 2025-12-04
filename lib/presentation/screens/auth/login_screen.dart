import 'package:chatapp/core/common/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                "Welcome Back",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Sign In to continue",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
              ),
              SizedBox(),
              CustomTextField(
                controller: emailController,
                hintText: "Email",
                prefixIcon: Icon(Icons.email),
              ),
              CustomTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
                prefixIcon: Icon(Icons.password),
                suffixIcon: Icon(Icons.visibility),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
