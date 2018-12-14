import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:office_management/common/show_dialog.dart';
import 'package:office_management/screens/register_page.dart';
import 'package:office_management/service/authorize_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      showDialogSingleButton(context, "title", "content", "ОК");
    }
  }

  checkForAuth() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String lastUser = preferences.getString("LastUser");
    String lastToken = preferences.getString("LastToken");
    String lastEmail = preferences.getString("LastEmail");
    String lastUserId = preferences.getString("LastUserId");

    if (lastUser != null && lastUser.length > 0) {
      Navigator.of(context).pushReplacementNamed("/HomeScreen");
      /*if (lastUser.displayName == null || lastUser.displayName.length == 0) {
        Navigator.of(context).pushReplacementNamed("/personal_data");
      } else {
        Navigator.pushReplacementNamed(context, "/activities");
      }*/
    }
    /* else {
      Navigator.of(context).pushReplacementNamed("/signin");
    }*/
  }

  @override
  void initState() {
    super.initState();
    checkForAuth();
    _saveCurrentRoute("/LoginScreen");
  }

  _saveCurrentRoute(String lastRoute) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('LastScreenRoute', lastRoute);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Авторизация",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 15.0),
                      /*child: Text(
                        "Авторизация",
                        style: TextStyle(fontSize: 30.0, color: Colors.black),
                      ),*/
                    )),
                Text(
                  "Пользователь",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: TextFormField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      hintText: "Введите имя пользователя",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Необходимо ввести имя пользователя!';
                      }
                    },
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                      //fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
                  child: Text(
                    "Пароль",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Введите пароль',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Необходимо ввести пароль!';
                      }
                    },
                    obscureText: true,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                      //fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
                  child: Container(
                    height: 65.0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.signInAlt,
                              size: 30,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                                loginRequest(
                                    context,
                                    _userNameController.text,
                                    _passwordController.text);
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.userPlus,
                              size: 30,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          RegisterPage()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
