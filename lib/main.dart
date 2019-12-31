import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagchat/root_page.dart';
import 'package:tagchat/viewmodel/chats_model.dart';
import 'package:tagchat/viewmodel/user_model.dart';
import 'locator.dart';

void main() {
  setupLocator();

  runApp(TagChat());
}

class TagChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(create: (context)=>UserModel(context)),
        ChangeNotifierProvider<ChatsModel>(create: (context)=>ChatsModel()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: RootPage(),),


    );
  }
}
