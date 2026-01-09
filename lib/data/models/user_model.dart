// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String userName;
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final bool isOnline;
  final Timestamp lastSeen;
  final Timestamp createdAt;
  final String? fcmToken;
  final List<String> blockedUsers;

  UserModel({
    required this.uid,
    required this.userName,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.isOnline = false,
    Timestamp? lastSeen,
    Timestamp? createdAt,
    this.fcmToken,
    this.blockedUsers = const [],
  }) : lastSeen = lastSeen ?? Timestamp.now(),
       createdAt = createdAt ?? Timestamp.now();

  UserModel copyWith({
    String? uid,
    String? userName,
    String? fullName,
    String? email,
    String? password,
    String? phoneNumber,
    bool? isOnline,
    Timestamp? lastSeen,
    Timestamp? createdAt,
    String? fcmToken,
    List<String>? blockedUsers,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: createdAt ?? this.createdAt,
      fcmToken: fcmToken ?? this.fcmToken,
      blockedUsers: blockedUsers ?? this.blockedUsers,
    );
  }

  factory UserModel.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      userName: data['username'],
      fullName: data['fullName'],
      email: data['email'],
      password: data['password'],
      phoneNumber: data['phoneNumber'],
      fcmToken: data['fcmToken'],
      isOnline: data['isOnline'],
      lastSeen: data['lastSeen'],
      createdAt: data['createdAt'],
      blockedUsers: data['blockedUsers']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': userName,
      'email': email,
      'fullName': fullName,
      'passwrod': password,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'lastSeen': lastSeen,
      'createdAt': createdAt,
      'fcmToken': fcmToken,
      'blockedUsers': blockedUsers,
    };
  }
}
