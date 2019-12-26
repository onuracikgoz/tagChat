import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagchat/login_signup_page.dart';
import 'package:tagchat/viewmodel/user_model.dart';

import 'homepage.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);

    if (_userModel.viewState == ViewState.Idle) {
      if (_userModel.user == null) {
        return LoginSignPage();
      } else {
        return HomePage();
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(backgroundColor: Colors.red,),
        ),
      );
    }
  }
}

Widget buildWaitingScreen() {
  return Scaffold(
    body: Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    ),
  );
}
