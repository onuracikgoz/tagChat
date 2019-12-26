import 'package:flutter/material.dart';
import 'package:tagchat/constant.dart';

Material buildMaterialButton(BuildContext context, Function onPress) {
  return Material(
    elevation: 6.0,
    borderRadius: BorderRadius.circular(30.0),
    color: Color(0xff01A0C7),
    child: MaterialButton(
      onPressed: onPress,
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(18.0, 15.0, 20.0, 15.0),

      child: Text("KONU BAŞLAT",
          textAlign: TextAlign.center,
          style: style.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
}
TextFormField buildTextFormField(String hintText) {
  return TextFormField(
    obscureText: false,
    maxLines: 1,
    style: style,
    autofocus: true,
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