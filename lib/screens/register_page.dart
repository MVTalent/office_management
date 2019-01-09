import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:office_management/service/authorize_api.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();

}
class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _doublePasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //TODO вынести компоненты формы("пользователь", "почта", "пароль") в отдельные виджеты
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Регистрация пользователя",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.grey[800],
      )
      /*Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 15.0),
                    child: Text(
                      "Введите данные пользователя",
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
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
                padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                child: Text(
                  "Электронная почта",
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
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    //hintText: 'Введите адрес электронной почты',
                      hintText: 'you@example.com',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Необходимо ввести адрес электронной почты!';
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
                padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
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
                  controller: _passwordController,
                  keyboardType: TextInputType.emailAddress,
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
                padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                child: Text(
                  "Пароль еще раз",
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
                  controller: _doublePasswordController,
                  keyboardType: TextInputType.emailAddress,
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
                padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
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
                              registerUserRequest(
                                  context,
                                  _userNameController.text,
                                  _emailController.text,
                                  _passwordController.text);
                            }
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
      ),*/
    );
  }
}