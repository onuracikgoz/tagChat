import 'package:flutter/material.dart';

import 'authentication.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.logoutCallback, this.userId});

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  signOut() async {
    try {
      await widget.auth.signOut();
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
            child: new Text("Hello World"),
          ),
          FlatButton(
            child: Text('Çıkıgrgrgrgş'),
            onPressed: () {
              signOut();
            },
          )
        ],
      ),
    );
  }
}
