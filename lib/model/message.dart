import 'package:cloud_firestore/cloud_firestore.dart';


class Message {
  final String userID;
  final String message;
  final Timestamp messageTime;
  final String userName;

  Message({this.userName, this.userID, this.message, this.messageTime});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'message': message,
      'messageTime': messageTime ?? FieldValue.serverTimestamp(),
      'userName' : userName,
    };
  }

  Message.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        message = map['message'],
        messageTime = map['messageTime'],
        userName = map['userName'];



}


