import 'package:cloud_firestore/cloud_firestore.dart';


class Chat {
  String userID;
  String title;
  String hashtag;
  bool isPrivate;
  String category;
  DateTime createdAt;


  Chat({this.userID,this.title,this.category,this.hashtag,this.isPrivate,this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'title': title,
      'category': category,
      'hashtag': hashtag,
      'isPrivate': isPrivate,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  Chat.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        title = map['title'],
        category = map['category'],
        hashtag = map['hashtag'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        isPrivate = map['isPrivate'];


}
