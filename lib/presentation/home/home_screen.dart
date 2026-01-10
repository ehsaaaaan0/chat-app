import 'package:chatapp/data/services/service_locator.dart';
import 'package:chatapp/logic/cubits/auth/auth_cubit.dart';
import 'package:chatapp/presentation/screens/auth/login_screen.dart';
import 'package:chatapp/router/app_router.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () async {
              await getit<AuthCubit>().signOut();
              getit<AppRouter>().pushAndRemoveUntil(LoginScreen());
            },
            child: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
