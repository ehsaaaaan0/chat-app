import 'package:chatapp/core/common/custom_button.dart';
import 'package:chatapp/core/common/custom_text_field.dart';
import 'package:chatapp/data/repositories/auth_repository.dart';
import 'package:chatapp/data/services/service_locator.dart';
import 'package:chatapp/logic/cubits/auth/auth_cubit.dart';
import 'package:chatapp/logic/cubits/auth/auth_state.dart';
import 'package:chatapp/presentation/home/home_screen.dart';
import 'package:chatapp/presentation/screens/auth/login_screen.dart';
import 'package:chatapp/router/app_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emaiController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  bool _isPasswordVisible = false;
  final _nameFocus = FocusNode();
  final _usernameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _phoneFocus = FocusNode();

  @override
  void dispose() {
    emaiController.dispose();
    passwordController.dispose();
    nameController.dispose();
    usernameController.dispose();
    phoneNumberController.dispose();
    _nameFocus.dispose();
    _usernameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Your Full Name";
    }
  }

  String? _validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Your userName";
    }
  }

  String? _validatEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Your Email";
    }
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Your Phone Number";
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Password";
    }
  }

  Future<void> handelSignUp() async {
    FocusScope.of(context).unfocus();
    if (_formkey.currentState?.validate() ?? false) {
      try {
        getit<AuthCubit>().signUp(
          fullName: nameController.text,
          email: emaiController.text,
          userName: usernameController.text,
          phoneNumber: phoneNumberController.text,
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
    return BlocListener<AuthCubit, AuthState>(
      bloc: getit<AuthCubit>(),
      listenWhen: (previous, current) {
        return previous.status != current.status ||
            previous.status != current.error;
      },
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          getit<AppRouter>().pushAndRemoveUntil(HomeScreen());
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Please fill in the details",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 30),
                  CustomTextField(
                    controller: nameController,
                    hintText: "Full Name",
                    focusNode: _nameFocus,
                    validator: _validateName,
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: usernameController,
                    hintText: "User Name",
                    validator: _validateUserName,
                    focusNode: _usernameFocus,
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: emaiController,
                    hintText: "Email",
                    focusNode: _emailFocus,
                    validator: _validatEmail,
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: phoneNumberController,
                    hintText: "Phone Number",
                    focusNode: _phoneFocus,
                    validator: _validatePhoneNumber,
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: passwordController,
                    hintText: "Password",
                    focusNode: _passwordFocus,
                    validator: _validatePassword,
                    obscureText: !_isPasswordVisible,
                    prefixIcon: Icon(
                      !_isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      icon: Icon(Icons.visibility),
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomButton(onPressed: handelSignUp, text: "Register"),
                  SizedBox(height: 16),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account?  ",
                        style: TextStyle(color: Colors.grey[600]),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                getit<AppRouter>().pop(context);
                                // Navigator.pop(context);
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
      ),
    );
  }
}
