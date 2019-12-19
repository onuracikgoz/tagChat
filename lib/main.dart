import 'package:flutter/material.dart';
import 'package:tagchat/root_page.dart';
import 'locator.dart';

void main() {
  setupLocator();

  runApp(TagChat());
}

class TagChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new RootPage()
    );
  }
}

