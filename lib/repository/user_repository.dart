import 'dart:io';

import 'package:tagchat/locator.dart';
import 'package:tagchat/model/chat.dart';
import 'package:tagchat/model/user.dart';
import 'package:tagchat/services/authentication.dart';
import 'package:tagchat/services/db_base.dart';
import 'package:tagchat/services/db_storage.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository implements Auth {
  Auth _firebaseAuth = locator<Auth>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  FirestoreStorageService _firestoreStorageService = locator<FirestoreStorageService>();

  AppMode appMode = AppMode.RELEASE;

  @override
  Future<User> getCurrentUser() async {
    if (appMode == AppMode.RELEASE) {
      User _user = await _firebaseAuth.getCurrentUser();
      if (_user != null) {
        return await _firestoreDBService.readUser(_user.userID);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<bool> isEmailVerified() {
    return null;
  }

  @override
  Future<void> sendEmailVerification() {
    return null;
  }

  @override
  Future<User> signIn(String email, String password) async {
    if (appMode == AppMode.RELEASE) {
      User _user = await _firebaseAuth.signIn(email, password);
      return _firestoreDBService.readUser(_user.userID);
    }

    return null;
  }

  @override
  Future<void> signOut() async {
    if (appMode == AppMode.RELEASE) {
      return await _firebaseAuth.signOut();
    } else {
      //başka bir veritabanı için alternatif

    }
  }

  @override
  Future<User> signUp(String email, String password) async {
    if (appMode == AppMode.RELEASE) {
      User _user = await _firebaseAuth.signUp(email, password);
      bool _sonuc = await _firestoreDBService.saveUser(_user);
      if (_sonuc) {
        return await _firestoreDBService.readUser(_user.userID);
      } else
        return null;
    } else {
      return null;
    }
  }

 Future<String> uploadFile(String userID, String fileType, File profilImgURL)async {
   if (appMode == AppMode.RELEASE) {

    var url=  await _firestoreStorageService.uploadFile(userID,fileType,profilImgURL);
  await _firestoreDBService.updateProfilImage(userID, url);

     return url;
   } else return null;


 }



  Future<bool> createChat(String userID, String title, String hashtag, bool isPrivate, String category) async {


    return await _firestoreDBService.createChat(userID, title, hashtag, isPrivate, category);
  }

  Future<List<Chat>> getAllChats()async {

    if (appMode == AppMode.RELEASE) {

      var allChat = await _firestoreDBService.getAllChats();
      return allChat;


    }
    return null;


  }
}
