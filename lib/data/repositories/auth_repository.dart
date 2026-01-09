import 'dart:math';

import 'package:chatapp/data/models/user_model.dart';
import 'package:chatapp/data/services/based_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository extends BasedRepository {
  Future<UserModel> signUp({
    required String fullName,
    required String email,
    required String userName,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final formatedPhoneNumber = phoneNumber.replaceAll(
        RegExp(r'\s+'),
        "".trim(),
      );

      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        throw "Failed to create user";
      }
      //Create a user model and save the user in the db firestore
      final userModel = UserModel(
        uid: userCredential.user!.uid,
        userName: userName,
        fullName: fullName,
        email: email,
        password: password,
        phoneNumber: formatedPhoneNumber,
      );
      await saveUSerData(userModel);
      return userModel;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserModel> SignIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        throw "Failed to Find User";
      }
      final userData = await getUserData(userCredential.user!.uid);
      return userData;
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUSerData(UserModel user) async {
    try {
      firestore.collection("user").doc(user.uid).set(user.toMap());
    } catch (e) {
      throw "Failed to save user Data";
    }
  }

  Future<UserModel> getUserData(String uid) async {
    try {
      final doc = await firestore.collection("users").doc(uid).get();
      if (!doc.exists) {
        throw "User data not found";
      }
      return UserModel.fromFireStore(doc);
    } catch (e) {
      throw "Failed to get user Data";
    }
  }
}
