import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tagchat/locator.dart';
import 'package:tagchat/model/message.dart';
import 'package:tagchat/model/user.dart';
import 'package:tagchat/repository/user_repository.dart';
import 'package:tagchat/services/authentication.dart';


enum ViewState { Idle, Busy }

class UserModel with ChangeNotifier implements Auth {
  ViewState _viewState = ViewState.Idle;
  String errorMessage;

  ViewState get viewState => _viewState;

  set state(ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  UserRepository _userRepository = locator<UserRepository>();

  User _user;

  User get user => _user;

  UserModel(BuildContext context) {
    getCurrentUser();
  }

  @override
  Future<User> getCurrentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.getCurrentUser();
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      print("viewmodel CURRENT USER HATASI" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
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
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signIn(email, password);
      errorMessage = " ";

      return _user;
    } catch (e) {
      print("viewmodel signin USER HATASI" + e.toString());
      errorMessage = e.message.toString();
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      state = ViewState.Busy;
      _user = null;
      return await _userRepository.signOut();
    } catch (e) {
      print("viewmodel signout USER HATASI" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signUp(String email, String password) async {
    try {
      state = ViewState.Busy;

      _user = await _userRepository.signUp(email, password);
      errorMessage = "";
      return _user;
    } finally {
      state = ViewState.Idle;
    }
  }

  showErrorMessage(String string) {}

  Future<String> uploadFile(String userID, String fileType, File profilFoto) async {

  return  await _userRepository.uploadFile(userID,fileType,profilFoto);



  }




  /*Future<List<Chat>> getAllChats()async {
    var allChat = await _userRepository.getAllChats();

    return allChat;
  } */


  Future<bool> sendMessage (Message message, String chatID)async{
    return await _userRepository.sendMessage(message,chatID);


  }

 Stream<List<Message>> getMessages(String chatID) {
   return  _userRepository.getMessages(chatID);



  }


}
