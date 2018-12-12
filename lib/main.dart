import 'package:flutter/material.dart';
import 'package:office_management/screens/NewsPage.dart';
import 'package:office_management/screens/ServicePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  int _selectedIndex = 0;
  Widget _bodyWidget = NewsPage();

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        _bodyWidget = NewsPage();
        break;
      case 1:
        _bodyWidget = ServicePage();
        break;
      default:
        _bodyWidget = NewsPage();
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _bodyWidget,/*Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _bodyWidget
              *//*Text('You have pushed the button this many times:',),
              Text('4444', style: Theme.of(context).textTheme.display1,
              ),*//*
            ],
          ),
        ),*/
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.blue,
              primaryColor: Colors.purple,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.white))),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Новости')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_laundry_service), title: Text('Сервисы')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), title: Text('Сотрудники')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.info), title: Text('Информация')),
            ],
            currentIndex: _selectedIndex,
            //fixedColor: Colors.deepPurple,
            onTap: _onItemTapped,
          ),
        ));
  }
}
