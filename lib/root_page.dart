import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagchat/constant.dart';
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
        return
          HomePage();
      }
    } else {
      return Scaffold(
        body: Center(
            child: Container(
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(child: Image.asset(
                    "images/logologo.png", width: 150.0, height: 150.0,)),
                  SizedBox(
                    width: 250.0,
                    child: TypewriterAnimatedTextKit(
                        speed: Duration(microseconds: 200000),
                        text: [
                          "Tagchat..."
                        ],
                        textStyle: loadingAppNameStyle,
                        textAlign: TextAlign.center,
                        alignment: AlignmentDirectional
                            .topStart // or Alignment.topLeft
                    ),
                  ),


                ],)),
            )),
      );
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
}