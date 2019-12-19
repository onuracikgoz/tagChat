import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tagchat/login_signup_page.dart';
import 'package:tagchat/repository/user_repository.dart';

import 'homepage.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  UserRepository _userRepository = UserRepository();
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId ;

  @override
  void initState() {
    super.initState();

    _userRepository.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.userID;
        }
        authStatus =
            user?.userID == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void loginCallBack() {
    _userRepository.getCurrentUser().then((user) {
      print(user);
      setState(() {
        _userId = user.userID.toString();
        authStatus = AuthStatus.LOGGED_IN;
      });
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
      case AuthStatus.NOT_LOGGED_IN:
        return LoginSignPage(

          loginCallBack: loginCallBack,
        );
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new HomePage(
            userId: _userId,

            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
