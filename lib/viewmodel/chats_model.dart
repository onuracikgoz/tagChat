import 'package:flutter/material.dart';
import 'package:tagchat/locator.dart';
import 'package:tagchat/model/chat.dart';
import 'package:tagchat/model/user.dart';
import 'package:tagchat/repository/user_repository.dart';


class ChatsModel with ChangeNotifier  {

  UserRepository _userRepository = locator<UserRepository>();
  @override
  Future<bool> createChat({String userID, String title, String hashtag, bool isPrivate, String category}) {
    
    return _userRepository.createChat(userID, title, hashtag, isPrivate, category);
  }

  @override
  Future<List<Chat>> getAllChats() {


    return _userRepository.getAllChats();
  }

  Future<List<User>>  getChatInfo(String chatID) async {

    return await _userRepository.getChatInfo(chatID);

  }

  Future<void> enterChat(String userID, String chatID)async {

    return await _userRepository.enterChat(userID,chatID);


  }







}