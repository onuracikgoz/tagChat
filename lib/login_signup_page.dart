import 'package:flutter/material.dart';
import 'package:tagchat/homepage.dart';
import 'authentication.dart';

class LoginSignPage extends StatefulWidget {

  LoginSignPage({this.auth, this.loginCallBack});

  final BaseAuth auth;
  final VoidCallback loginCallBack;

  State<StatefulWidget> createState() => new _LoginSignPage();
}

class _LoginSignPage extends State<LoginSignPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;
  bool _isLoginForm;
  bool _isLoading;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    else {
    setState(() {
     _isLoading = false; 
    });
    return false; }
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });

    if (validateAndSave()) {
      String userId = ""; 
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
          HomePage();
        } else {
          userId = await widget.auth.signUp(_email, _password);
          //widget.auth.sendEmailVerification();
          //_showVerifyEmailSentDialog();
          print('Signed up user: $userId');

        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallBack();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    Widget emailField() { return  TextFormField(
      obscureText: false,
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      style: style,
      autofocus: false,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff01A0C7),
            ),
            borderRadius: BorderRadius.circular(32.0)),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'E-mail',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      validator: (value) => value.isEmpty ? 'Lütfen e-mail giriniz.' : null,
      onSaved: (value) => _email = value.trim(),
    ); }

    Widget passwordField () { return TextFormField(
      obscureText: true,
      style: style,
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
    ); }

    final logo = Padding(
      padding: EdgeInsets.all(1.0),
      child: SizedBox(
        height: 155.0,
        child: Image.asset(
          "images/logologo.png",
          fit: BoxFit.contain,
        ),
      ),
    );

  

    Widget primaryButton (){ 
      
      return Material(
      elevation: 6.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(18.0, 15.0, 20.0, 15.0),
        onPressed: validateAndSubmit,
        child: Text(_isLoginForm ? 'Login' : 'Create account',
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );}

    Widget secondaryButton ()  {  return MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(18.0, 15.0, 20.0, 15.0),
      onPressed: toggleFormMode,
      child: Text(
          _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
          textAlign: TextAlign.center,
          style: style.copyWith(
              color: Color(0xff01A0C7), fontWeight: FontWeight.bold)),
    );}

    Widget _showForm() {
      return new Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(flex: 4, child: logo),
                  Expanded(
                    flex: 3,
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        Expanded(child: emailField()),
                        Expanded(child: passwordField()),
                      ],
                    )),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: <Widget>[
                        Expanded(flex: 1, child: primaryButton()),
                        SizedBox(
                          height: 30.0,
                        ),
                        Expanded(flex: 1, child: secondaryButton()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: showErrorMessage(),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }



    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            _showForm(),
            _showCircularProgress(),
          ],
        ),
      ),
    );
  }
}
