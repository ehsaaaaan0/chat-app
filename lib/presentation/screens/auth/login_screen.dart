import 'package:chatapp/core/common/custom_button.dart';
import 'package:chatapp/core/common/custom_text_field.dart';
import 'package:chatapp/core/utils/ui_utils.dart';
import 'package:chatapp/data/services/service_locator.dart';
import 'package:chatapp/logic/cubits/auth/auth_cubit.dart';
import 'package:chatapp/logic/cubits/auth/auth_state.dart';
import 'package:chatapp/presentation/home/home_screen.dart';
import 'package:chatapp/presentation/screens/auth/signup_screen.dart';
import 'package:chatapp/router/app_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  bool _isPasswordVisible = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  String? _validatEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Your Email";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Password";
    }
    return null;
  }

  Future<void> loginUser() async {
    FocusScope.of(context).unfocus();
    if (_formkey.currentState?.validate() ?? false) {
      try {
        await getit<AuthCubit>().signIn(
          email: emailController.text,
          password: passwordController.text,
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } else {
      print("form validation failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: getit<AuthCubit>(),

      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          getit<AppRouter>().pushAndRemoveUntil(HomeScreen());
        } else if (state.status == AuthStatus.error && state.error != null) {
          UiUtils.showSnackBar(
            context,
            message: state.error ?? "An error occurred",
            isError: true,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      "Welcome Back",
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Sign In to continue",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                    ),
                    SizedBox(height: 30),
                    CustomTextField(
                      controller: emailController,
                      hintText: "Email",
                      focusNode: _emailFocus,
                      validator: _validatEmail,
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      controller: passwordController,
                      hintText: "Password",
                      focusNode: _passwordFocus,
                      validator: _validatePassword,
                      obscureText: !_isPasswordVisible,
                      prefixIcon: Icon(Icons.password_outlined),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      onPressed: loginUser,
                      text: "Login",
                      child: state.status == AuthStatus.loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account?  ",
                          style: TextStyle(color: Colors.grey[600]),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  getit<AppRouter>().push(SignupScreen());
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => SignupScreen(),
                                  //   ),
                                  // );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
