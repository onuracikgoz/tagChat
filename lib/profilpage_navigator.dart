import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tagchat/constant.dart';
import 'package:tagchat/viewmodel/user_model.dart';

class ProfilPageNavigator extends StatefulWidget {
  @override
  _ProfilPageNavigatorState createState() => _ProfilPageNavigatorState();
}

class _ProfilPageNavigatorState extends State<ProfilPageNavigator> {
  File _profilFoto;

  signOut(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);
    _userModel.signOut();
  }

  void _kameradanFotoCek(BuildContext context) async {
    var _yeniResim = await ImagePicker.pickImage(source: ImageSource.camera);
    _profilFoto = _yeniResim;
    UserModel _userModel = Provider.of<UserModel>(context);
    await _userModel.uploadFile(_userModel.user.userID,"Profile_image",_profilFoto);
    setState(() {
      _profilFoto = _yeniResim;
      Navigator.of(context).pop();
    });
  }

  void _galeridenResimSec(BuildContext context) async {
    var _yeniResim = await ImagePicker.pickImage(source: ImageSource.gallery);
    _profilFoto = _yeniResim;
    UserModel _userModel = Provider.of<UserModel>(context);
   await _userModel.uploadFile(_userModel.user.userID,"Profile_image",_profilFoto);
    setState(() {
      _profilFoto = _yeniResim;
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5.0)],
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                cikisButton(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "44",
                          style: cikisButtonStyle,
                        ),
                        Text(
                          "Takipçi",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: profilePicture(context),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "5",
                          style: cikisButtonStyle,
                        ),
                        Text(
                          "Takip",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(

                     _userModel.user.userName,

                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        )),
      )),
    );
  }

  GestureDetector profilePicture(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);
    return GestureDetector(

      onTap: () {
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
                      onTap: () {
                        _kameradanFotoCek(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.image),
                      title: Text("Galeriden Seç"),
                      onTap: () {
                        _galeridenResimSec(context);
                      },
                    ),
                  ],
                ),
              );
            });
      },
      child: Material(
        elevation: 30.0,
        shape: CircleBorder(side:  BorderSide(width:3.0)),
        clipBehavior: Clip.antiAlias,
        child: CircleAvatar(

          radius: 75,
          backgroundColor: Colors.white,
          backgroundImage: _profilFoto == null
              ? NetworkImage(_userModel.user.profilURL)
              : FileImage(_profilFoto),
        ),
      ),


    );
  }

  GestureDetector cikisButton(BuildContext context) {
    return GestureDetector(
      onTap: () => signOut(context),
      child: Text(
        "Çıkış",
        style: cikisButtonStyle,
      ),
    );
  }
}
