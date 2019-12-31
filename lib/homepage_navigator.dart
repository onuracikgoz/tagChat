import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagchat/chat_screen.dart';
import 'package:tagchat/constant.dart';
import 'package:tagchat/model/chat.dart';
import 'package:tagchat/model/user.dart';
import 'package:tagchat/new_chat.dart';
import 'package:tagchat/viewmodel/chats_model.dart';

class HomePageNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChatsModel _chatsModel = Provider.of<ChatsModel>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            FutureBuilder<List<Chat>>(
                future: _chatsModel.getAllChats(),
                builder: (context, result) {
                  if (result.hasData) {
                    var allChat = result.data;
                    if (allChat.length > 0) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: allChat.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(allChat[index].title),
                            onTap: () {
                              _showModalBottomSheet(
                                  context, allChat, index, _chatsModel);
                            },
                            subtitle: Text(allChat[index].hashtag +
                                " " +
                                allChat[index].category),
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
                        MaterialPageRoute(
                            builder: (context) => (NewChatPage())),
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

  void _showModalBottomSheet(BuildContext context, List<Chat> allChat,
      int index, ChatsModel _chatsModel) {
    showModalBottomSheet(
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Material(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
            ),
            elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildInfoTitle(allChat[index].title),
                  ),
                  FutureBuilder<List<User>>(
                    future: _chatsModel.getChatInfo(allChat[index].chatID),
                    builder: (context, result) {
                      if (result.hasData) {
                        var usersInfo = result.data;
                        if (usersInfo.length > 0) {
                          return Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: usersInfo.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(usersInfo[index].userName),
                                    leading: Material(
                                      shape: CircleBorder(
                                          side: BorderSide(
                                              width: 1.0, color: Colors.black)),
                                      elevation: 8.0,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            usersInfo[index].profilURL),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        } else {
                          return Container(
                            child: Center(child: Text("Kimse yok")),
                          );
                        }
                      } else {
                        return Container(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                  ),
                  buildMaterialButton(
                      context: context,
                      onPress: () {
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).push(
                          MaterialPageRoute(
                              builder: (context) => (ChatScreen(
                                    chatID: allChat[index].chatID,
                                  ))),
                        );
                      })
                ],
              ),
            ),
          );
        });
  }

  Widget buildMaterialButton({BuildContext context, Function onPress}) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 30.0, top: 10.0, bottom: 10.0, right: 0.0),
      child: Material(
        elevation: 6.0,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
        ),
        color: /*Color(0xff01A0C7),*/ Colors.lightBlueAccent,
        child: MaterialButton(
          onPressed: onPress,
          minWidth: MediaQuery.of(context).size.width,
          child: Text("Konuya Gir",
              textAlign: TextAlign.left,
              style: loginPrimaryButton.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildInfoTitle(String text) {
    return Text(text);
  }
}
