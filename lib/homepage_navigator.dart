import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagchat/chat_screen.dart';
import 'package:tagchat/model/chat.dart';
import 'package:tagchat/new_chat.dart';
import 'package:tagchat/viewmodel/user_model.dart';

class HomePageNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            FutureBuilder<List<Chat>>(
                future: _userModel.getAllChats(),
                builder: (context, result) {
                  if (result.hasData) {
                    var allChat = result.data;
                    if (allChat.length > 0) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: allChat.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onLongPress: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: 160,
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(Icons.camera),
                                            title: Text("Kameradan Çek"),
                                            onTap: () {},
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.image),
                                            title: Text("Galeriden Seç"),
                                            onTap: () {},
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: ListTile(
                              title: Text(allChat[index].title),
                              onTap: () {
                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).push(
                                  MaterialPageRoute(
                                      builder: (context) => (ChatScreen(chatID: allChat[index].chatID,))),
                                );
                              },
                              subtitle: Text(allChat[index].hashtag +
                                  " " +
                                  allChat[index].category),
                            ),
                          );
                        },
                      );
                    } else {
                      return Container(
                        child: Text(
                          "Açılan Konu yok",
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: FlatButton(
                    child: Text("Yeni Konu Aç"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => (NewChatPage())),
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
