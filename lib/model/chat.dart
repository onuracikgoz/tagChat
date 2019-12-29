import 'package:cloud_firestore/cloud_firestore.dart';


class Chat {
  final String chatID;
  final String userID;
  final String title;
  final String hashtag;
  final bool isPrivate;
  final String category;
  final DateTime createdAt;


  Chat({this.chatID,this.userID,this.title,this.category,this.hashtag,this.isPrivate,this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'chatID' : chatID,
      'userID': userID,
      'title': title,
      'category': category,
      'hashtag': hashtag,
      'isPrivate': isPrivate,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  Chat.fromMap(Map<String, dynamic> map)
      : chatID = map['chatID'],
        userID = map['userID'],
        title = map['title'],
        category = map['category'],
        hashtag = map['hashtag'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        isPrivate = map['isPrivate'];


}
