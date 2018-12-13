/*
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:office_management/model/user.dart';

class UserAuth {

  //To create new User
  Future<FirebaseUser> createUser(User user) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return await firebaseAuth
        .createUserWithEmailAndPassword(
        email: user.email, password: user.password);;
  }

  //To verify new User
  Future<FirebaseUser> verifyUser(User user) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return await firebaseAuth
        .signInWithEmailAndPassword(
        email: user.email, password: user.password);
  }

  static Future<Null> logout()async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return await firebaseAuth.signOut();
  }
}*/
