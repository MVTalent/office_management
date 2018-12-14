import 'package:flutter/material.dart';
import 'package:office_management/common/loading_state.dart';
import 'package:office_management/screens/home_page.dart';
import 'package:office_management/screens/info_page.dart';
import 'package:office_management/screens/login_page.dart';
import 'package:office_management/screens/news_page.dart';
import 'package:office_management/screens/people_page.dart';
import 'package:office_management/screens/register_page.dart';
import 'package:office_management/screens/service_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        "/HomeScreen": (BuildContext context) => HomePage(),
        "/LoginScreen": (BuildContext context) => LoginPage(),
        "/RegisterPage": (BuildContext context) => RegisterPage(),
      },
      home: MyHomePage(title: 'Управление офисом'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }
}
