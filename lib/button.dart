import 'package:flutter/material.dart';

import 'constant.dart';

class Button extends StatefulWidget {
  final Function onPress;
  final String buttonText;
  final String buttonText2;
  final bool value ;
  final TextStyle style;

  Button({this.onPress, this.buttonText, this.buttonText2,this.value = true,this.style});

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(18.0, 15.0, 20.0, 15.0),
        onPressed: widget.onPress,
        child: Text(widget.value ? widget.buttonText : widget.buttonText2,
            textAlign: TextAlign.center,
            style: loginPrimaryButton),
      ),
    );
  }
}
