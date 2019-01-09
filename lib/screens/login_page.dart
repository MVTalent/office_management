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
  final TextEditingController _emailController = TextEditingController();
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
    return Scaffold(
        body: Container(
          color: Colors.grey[800],
          //height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 80.0, bottom: 50.0),
                child: Center(
                  child: new Column(
                    children: <Widget>[
                      Container(
                        height: 128.0,
                        width: 128.0,
                        child: new CircleAvatar(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          radius: 100.0,
                          child: new Text(
                            "ТС",
                            style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:Colors.blue,
                            width: 2.0,
                          ),
                          shape: BoxShape.circle,
                          //image: DecorationImage(image: this.logo)
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: new Text(
                          "Управление офисом",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18.0),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              new Container(
                //width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Padding(
                      padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                      child: Icon(
                        Icons.alternate_email,
                        color: Colors.white,
                      ),
                    ),
                    new Expanded(
                      child: TextField(
                        controller: _emailController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'example@mail.com',
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                //width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Padding(
                      padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                      child: Icon(
                        Icons.lock_open,
                        color: Colors.white,
                      ),
                    ),
                    new Expanded(
                      child: TextField(
                        obscureText: true,
                        controller: _passwordController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '*********',
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                //width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new FlatButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        color: Colors.blue,
                        onPressed: () {
                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                            loginRequest(
                                context,
                                _emailController.text,
                                _passwordController.text);
                        },
                        child: Text(
                          "ВОЙТИ",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              new Container(
                //width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new FlatButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        //color: Colors.transparent,
                        onPressed: () => {},
                        child: Text(
                          "Забыли пароль?",
                          style: TextStyle(color: Colors.white.withOpacity(0.5)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              new Expanded(child: Divider(color: Colors.white,),),

              new Container(
                //width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0, bottom: 20.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new FlatButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        color: Colors.transparent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RegisterPage()));
                        },
                        child: Text(
                          "У вас нет аккаунта? Создайте!",
                          style: TextStyle(color: Colors.white.withOpacity(0.5)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
    /*return WillPopScope(
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
                      *//*child: Text(
                        "Авторизация",
                        style: TextStyle(fontSize: 30.0, color: Colors.black),
                      ),*//*
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
    );*/
  }
}
