import 'package:flutter/material.dart';
import 'package:office_management/screens/info_page.dart';
import 'package:office_management/screens/news_page.dart';
import 'package:office_management/screens/people_page.dart';
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
  int _page = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onItemTapped(int page) {
    _pageController.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: PageView(
          children: <Widget>[
            NewsPage(),
            ServicePage(),
            PeoplePage(),
            InfoPage()
          ],
        onPageChanged: onPageChanged,
        controller: _pageController,),
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
            currentIndex: _page,
            //fixedColor: Colors.deepPurple,
            onTap: _onItemTapped,
          ),
        ));
  }
}
