

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagchat/constant.dart';
import 'package:tagchat/viewmodel/chats_model.dart';
import 'package:tagchat/viewmodel/user_model.dart';

class NewChatPage extends StatefulWidget {
  @override
  _NewChatPageState createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCategory;
  bool _monVal = false;
  Function onPress;
  String _chatTitle;
  String _hashtag;
  final _formKey = new GlobalKey<FormState>();

  List _category = ["Ekonomi", "Spor", "Oyun", "Sinema", "Sohbet"];

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCategory = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _category) {
      items.add(new DropdownMenuItem(
          value: city,
          child: Container(
              child: new Text(
                city,
                style: loginPrimaryButton,
              ))));
    }
    return items;
  }

  void changedDropDownItem(String selectedCategory) {
    setState(() {
      _currentCategory = selectedCategory;
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildTitleTextField("Konu Başlığı Giriniz",1),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildTitleTextField("#Hashtag1, #Hashtag2, ...",2),
                ),
                Text("Lütfen kategori seç"),
                DropdownButton(
                  value: _currentCategory,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _monVal,
                      onChanged: (bool value) {
                        setState(() {
                          _monVal = value;
                        });
                      },
                    ),
                    Text("Chat Profilinize Kaydedilsin mi?"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildMaterialButton(context: context, onPress: ()=> createChat(context)

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


createChat (BuildContext context){
  UserModel _userModel = Provider.of<UserModel>(context);
  ChatsModel _chatModel = Provider.of<ChatsModel>(context);
    if (validateAndSave()){
      _chatModel.createChat(
          userID: _userModel.user.userID,
          category: _currentCategory,
          hashtag: _hashtag,
          isPrivate: _monVal ? true:false,
          title:  _chatTitle
      );

    }
}

  Material buildMaterialButton({BuildContext context, Function onPress}) {
    return Material(
      elevation: 6.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        onPressed: onPress,
        minWidth: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.fromLTRB(18.0, 15.0, 20.0, 15.0),

        child: Text("KONU BAŞLAT",
            textAlign: TextAlign.center,
            style: loginPrimaryButton.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget buildTitleTextField(String hintText,int textFieldType) {
    return TextFormField(
      obscureText: false,
      maxLines: 1,
      style: loginPrimaryButton,
      autofocus: false,
      validator: (value) =>
      value.isEmpty
          ? 'Lütfen Konu Başlığı giriniz.'
          : null,
      onSaved: (value) => textFieldType == 1 ? _chatTitle = value : _hashtag = value,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff01A0C7),
            ),
            borderRadius: BorderRadius.circular(32.0)),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
  }




  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      setState(() {});
      return false;
    }
  }

}




