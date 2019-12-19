import 'package:flutter/material.dart';

import 'package:tagchat/repository/user_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({this.logoutCallback, this.userId});

  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserRepository _userRepository = UserRepository();
  signOut() async {
    try {
      await _userRepository.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter login demo"),
      ),
      body: Column(
        children: <Widget>[
          new Container(
            child: new Text("Hoşgeldin " + widget.userId),
          ),
          FlatButton(
            child: Text('Çıkış'),
            onPressed: () {
              signOut();
            },
          )
        ],
      ),
    );
  }
}
