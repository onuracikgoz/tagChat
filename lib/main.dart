import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagchat/root_page.dart';
import 'package:tagchat/viewmodel/user_model.dart';
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
        home: ChangeNotifierProvider(
          
          builder: (context)=>UserModel(context),
          child: RootPage(),
          create: (context)=>UserModel(context)),
          
        );
  }
}
