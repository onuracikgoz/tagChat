import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userID;
  String email;
  String userName;
  String profilURL;
  DateTime createdAt;
  DateTime updatedAt;
  int seviye;

  User({ this.userID, this.email});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'userName':
      userName ?? email.substring(0, email.indexOf('@')) + randomNumber(),
      'profilURL': profilURL ??
          'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png',
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
      'seviye': seviye ?? 1,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        email = map['email'],
        userName = map['userName'],
        profilURL = map['profilURL'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updatedAt = (map['updatedAt'] as Timestamp).toDate(),
        seviye = map['seviye'];
  @override
  String toString() {
    return 'User{userID: $userID, email: $email, userName: $userName, profilURL: $profilURL, createdAt: $createdAt, updatedAt: $updatedAt, seviye: $seviye}';
  }
  String randomNumber() {
    int _randomNumber = Random().nextInt(999999);
    return _randomNumber.toString();
  }
}
