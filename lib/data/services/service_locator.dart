import 'package:chatapp/data/repositories/auth_repository.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/logic/cubits/auth/auth_cubit.dart';
import 'package:chatapp/router/app_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getit = GetIt.instance;

Future<void> setUpServiceLocator() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  getit.registerLazySingleton(() => AppRouter());
  getit.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  getit.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getit.registerLazySingleton(() => AuthRepository());
  getit.registerFactory(() => AuthCubit(authRepository: AuthRepository()));
}
