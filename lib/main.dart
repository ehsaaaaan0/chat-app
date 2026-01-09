import 'package:chatapp/config/theme/app_theme.dart';
import 'package:chatapp/data/services/service_locator.dart';
import 'package:chatapp/presentation/screens/auth/login_screen.dart';
import 'package:chatapp/router/app_router.dart';
import 'package:flutter/material.dart';

void main() async {
  await setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',

      debugShowCheckedModeBanner: false,
      navigatorKey: getit<AppRouter>().navigatorKey,
      theme: AppTheme.lightTheme,
      home: LoginScreen(),
    );
  }
}

