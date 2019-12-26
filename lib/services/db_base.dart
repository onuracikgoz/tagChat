import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tagchat/model/chat.dart';
import 'package:tagchat/model/user.dart';

abstract class DBBase {
  Future<bool> saveUser(User user);

  Future<User> readUser(String userID);

  Future<bool> updateProfilImage(String userID, String profilImgURL);

  Future<bool> createChat(String userID, String title, String hashtag,
      bool isPrivate, String category);

  Future<List<Chat>> getAllChats();
}

class FirestoreDBService implements DBBase {
  Firestore _firebaseDb = Firestore.instance;

  @override
  Future<bool> saveUser(User user) async {
    DocumentSnapshot _okunanUser =
        await Firestore.instance.document("users/${user.userID}").get();

    if (_okunanUser.data == null) {
      await _firebaseDb
          .collection("users")
          .document(user.userID)
          .setData(user.toMap());
      return true;
    } else {
      return true;
    }
  }

  @override
  Future<User> readUser(String userID) async {
    DocumentSnapshot _readUser =
        await _firebaseDb.collection("users").document(userID).get();

    Map<String, dynamic> _readUserMap = _readUser.data;

    User _readUserInfo = User.fromMap(_readUserMap);

    return _readUserInfo;
  }

  @override
  Future<bool> updateProfilImage(String userID, String profilImgURL) async {
    await _firebaseDb
        .collection("users")
        .document(userID)
        .updateData({'profilURL': profilImgURL});
    return true;
  }

  @override
  Future<bool> createChat(String userID, String title, String hashtag,
      bool isPrivate, String category) async {
    Chat _chat = Chat(
        userID: userID,
        title: title,
        category: category,
        hashtag: hashtag,
        isPrivate: isPrivate);

    await _firebaseDb.collection("chats").document().setData(_chat.toMap());
    return true;
  }

  @override
  Future<List<Chat>> getAllChats() async {
    try{
      QuerySnapshot querySnapshot =
      await _firebaseDb.collection("chats").getDocuments();
      List<Chat> allChats = [];

      allChats = querySnapshot.documents.map((aChat) => Chat.fromMap(aChat.data)).toList();

      print(allChats.toString());

      return allChats;

    }catch(e){
      print(e.message.toString());
      return null;

    }

  }
}
