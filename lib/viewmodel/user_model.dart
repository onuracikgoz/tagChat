
import 'package:flutter/material.dart';
import 'package:tagchat/authentication.dart';
import 'package:tagchat/locator.dart';
import 'package:tagchat/model/user.dart';
import 'package:tagchat/repository/user_repository.dart';

enum ViewState { Idle, Busy }

class UserModel with ChangeNotifier implements Auth {
  ViewState _viewState = ViewState.Idle;

  ViewState get viewState => _viewState;

  set state(ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  UserRepository _userRepository = locator<UserRepository>();
  User _user;

  @override
  Future<User> getCurrentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.getCurrentUser();
      return _user;
    } catch (e) {
      print("CURRENT USER HATASI" + e.toString());
      return null; 
    } finally {
      _viewState = ViewState.Idle;
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

    return _user;
    } catch (e) {
      print("CURRENT USER HATASI" + e.toString());
      return null;
    } finally {
      _viewState = ViewState.Idle;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      state = ViewState.Busy;
      return await _userRepository.signOut;
    } catch (e) {
      print("CURRENT USER HATASI" + e.toString());
      return null;
    } finally {
      _viewState = ViewState.Idle;
    }
  }

  @override
  Future<User> signUp(String email, String password) async {
    try {
      _viewState = ViewState.Busy;

      _user = await _userRepository.signUp(email, password);
      return _user;
    } catch (e) {
      print("CURRENT USER HATASI" + e.toString());
      return null;
    } finally {
      _viewState = ViewState.Idle;
    }
  }
}
