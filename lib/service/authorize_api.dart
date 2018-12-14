import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:office_management/common/show_dialog.dart';
import 'package:office_management/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<User> loginRequest(BuildContext context, String username, String password) async {
  final url = "https://localhost:8080/login";

  Map<String, String> body = {
    'username': username,
    'password': password,
  };

  /*final response = await http.post(
    url,
    body: body,
  );*/

  var userData = "{"
        "\"name\": \"Test\","
        "\"email\": \"test@.mail.ru\","
        "\"token\": \"cd46a946-6a81-44e2-8875-52a850257367\","
        "\"userId\": \"49510d91-ebcf-4cf5-a15b-e22b76f55165\""
      "}";

  //if (response.statusCode == 200) {
    final userJson = json.decode(userData);
    saveCurrentLogin(userJson);
    Navigator.of(context).pushReplacementNamed('/HomeScreen');

    return User.fromJson(userJson);
  /*} else {
    final responseJson = json.decode(response.body);

    saveCurrentLogin(responseJson);
    showDialogSingleButton(
        context,
        "Ошибка авторизации",
        "Возможно, вы указали неверную комбинацию «Имя пользователя» / «Пароль». "
        "Пожалуйста, попробуйте еще раз или обратитесь к представителю службы поддержки",
        "ОК");
    return null;
  }*/
}

Future<User> requestLogoutAPI(BuildContext context) async {
  /*final url = "https://localhost:8080/logout";
  var token;

  await getToken().then((result) {
    token = result;
  });

  final response = await http.post(
    url,
    headers: {HttpHeaders.authorizationHeader: "Token $token"},
  );*/

  //if (response.statusCode == 200) {
    saveLogout();
    return null;
  /*} else {
    saveLogout();
    return null;
  }*/
}

Future<String> getToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String getToken = await preferences.getString("LastToken");
  return getToken;
}

Future<Null> saveLogout() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString('LastUser', "");
  await preferences.setString('LastToken', "");
  await preferences.setString('LastEmail', "");
  await preferences.setString('LastUserId', "");
}

Future<Null> saveCurrentLogin(Map responseJson) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var user;
  if ((responseJson != null && responseJson.isNotEmpty)) {
    user = User.fromJson(responseJson).userName;
  } else {
    user = "";
  }
  var token = (responseJson != null && responseJson.isNotEmpty) ? User.fromJson(responseJson).token : "";
  var email = (responseJson != null && responseJson.isNotEmpty) ? User.fromJson(responseJson).email : "";
  var id = (responseJson != null && responseJson.isNotEmpty) ? User.fromJson(responseJson).userId : "";

  await preferences.setString('LastUser', (user != null && user.length > 0) ? user : "");
  await preferences.setString('LastToken', (token != null && token.length > 0) ? token : "");
  await preferences.setString('LastEmail', (email != null && email.length > 0) ? email : "");
  await preferences.setString('LastUserId', (id != null && id.length > 0) ? id : "");
}

Future<User> registerUserRequest(BuildContext context, String username, String email, String password) {
  return null;
}