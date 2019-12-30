

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagchat/constant.dart';
import 'package:tagchat/model/message.dart';
import 'package:tagchat/viewmodel/user_model.dart';

class ChatScreen extends StatefulWidget {
  final String chatID;

  ChatScreen({this.chatID});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _messageController = TextEditingController();
  var _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    String _chatID = widget.chatID;
    UserModel _userModel = Provider.of<UserModel>(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: StreamBuilder<List<Message>>(
              stream: _userModel.getMessages(_chatID),
              builder: (context, streamMessages) {
                if (!streamMessages.hasData) {
                  return Container(
                      child: Center(child: CircularProgressIndicator()));
                } else {
                  return ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var _streamMessage = streamMessages.data[index];
                      return messageBallon(
                          messageText: _streamMessage.message,
                          userID: _streamMessage.userID,
                      isMe: _streamMessage.userID == _userModel.user.userID,
                      userName: _streamMessage.userName,
                        date: _streamMessage.messageTime
                      );
                    },
                    itemCount: streamMessages.data.length,
                  );
                }
              },
            )),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        style: style,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff01A0C7),
                              ),
                              borderRadius: BorderRadius.circular(32.0)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Bir mesaj yaz",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                    Container(

                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: FloatingActionButton(
                        elevation: 1.0,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.send,
                          size: 35,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _sendMesage(context);
                          _messageController.clear();
                          _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut,);
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _sendMesage(BuildContext context) async {
    UserModel _userModel = Provider.of<UserModel>(context);
    if (_messageController.text.trim().length > 0) {
      Message _sendingMessage = Message(
        userID: _userModel.user.userID,
        message: _messageController.text,

        userName: _userModel.user.userName
      );
      _userModel.sendMessage(_sendingMessage, widget.chatID);
    }
  }

  messageBallon({String messageText, String userID, bool isMe,String userName,Timestamp date}) {



    String _messageTime;
    String _timeConvert(Timestamp date){

      var _dateConvert = DateFormat.Hm();
      var _time = _dateConvert.format(date.toDate());
      return _time;

    }


    try{
      _messageTime = _timeConvert(date ?? Timestamp(1,1));
    } catch(e){


    }







return Padding(
      padding: EdgeInsets.only(left: 10.0,right: 10.0,bottom: 7.0,top: 4.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[

          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end: MainAxisAlignment.start,
            children: <Widget>[
              isMe ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_messageTime,style: timeStyle,)) : Text("") ,

              Flexible(
                child: Material(
                  borderRadius: isMe
                      ? BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0))
                      : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  elevation: 5.0,
                  color: isMe ? Colors.lightBlueAccent : Colors.white,
                  child: Column(
                    crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: <Widget>[
                      !isMe?
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0,left: 15.0,right: 15.0,bottom: 2.0),
                        child: Text(userName,style: TextStyle(color: Colors.orange),),
                      ): Text("",style: TextStyle(fontSize: 5.0),),
                      Padding(
                        padding: EdgeInsets.only(top: 2.0,left: 15.0,right: 10.0,bottom: 10.0),
                        child: Text(
                          messageText,
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black54,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              isMe ? Text("") :
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_messageTime,style: timeStyle,),
              )
            ],
          ),
        ],
      ),
    );

  }
}
