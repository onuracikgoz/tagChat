import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagchat/constant.dart';
import 'package:tagchat/model/user.dart';
import 'package:tagchat/viewmodel/user_model.dart';

class LoginSignPage extends StatefulWidget {
  State<StatefulWidget> createState() => new _LoginSignPage();
}

class _LoginSignPage extends State<LoginSignPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  bool _isLoginForm;

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

  void validateAndSubmit(BuildContext context) async {
    setState(() {});

    if (validateAndSave()) {
      User _user;
      final _userModel = Provider.of<UserModel>(context);

      if (_isLoginForm) {
        _user = await _userModel.signIn(_email, _password);
        print('Signed in: $_user');
      } else {
        _user = await _userModel.signUp(_email, _password);
        //widget.auth.sendEmailVerification();
        //_showVerifyEmailSentDialog();
        print('Signed up user: $_user');
      }

//_formKey.currentState.reset();

    }
  }

  @override
  void initState() {
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            _showForm(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      obscureText: false,
      initialValue: "onur@onur.com",

      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      style: loginEmailField,
      autofocus: false,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff01A0C7),
            ),
            borderRadius: BorderRadius.circular(32.0)),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

        hintText: "e-mail",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      validator: (value) => value.isEmpty ? 'Lütfen e-mail giriniz.' : null,
      onSaved: (value) => _email = value.trim(),
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      style: loginPasswordField,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff01A0C7),
              ),
              borderRadius: BorderRadius.circular(32.0)),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) => value.isEmpty ? 'Lütfen şifre giriniz.' : null,
      onSaved: (value) => _password = value.trim(),
    );
  }

  final logo = Padding(
    padding: EdgeInsets.all(20.0),
    child: SizedBox(
      height: 100.0,
      child: Image.asset(
        "images/logologo.png",
        fit: BoxFit.contain,
      ),
    ),
  );

  Widget primaryButton() {
    return Material(
      elevation: 6.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(18.0, 15.0, 20.0, 15.0),
        onPressed: () => validateAndSubmit(context),
        child: Text(_isLoginForm ? 'Login' : 'Create account',
            textAlign: TextAlign.center,
            style: loginPrimaryButton),
      ),
    );
  }

  Widget secondaryButton() {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(18.0, 15.0, 20.0, 15.0),
      onPressed: toggleFormMode,
      child: Text(
          _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
          textAlign: TextAlign.center,
          style: loginSecondButton),
    );
  }

  Widget _showForm() {
    final _userModel = Provider.of<UserModel>(context);
    return new Center(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0 ,left: 15.0,bottom: 30.0,top: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 logo,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: emailField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: passwordField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: primaryButton(),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: secondaryButton(),
                ),
                Text(_userModel.errorMessage != null
                    ? _userModel.errorMessage
                    : '')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
