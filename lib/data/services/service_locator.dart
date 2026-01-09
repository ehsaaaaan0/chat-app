import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getit = GetIt.instance;

Future<void> setUpServiceLocator() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  getit.registerLazySingleton(() => AppRouter());
}
