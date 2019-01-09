import 'package:flutter/material.dart';
import 'package:office_management/model/user.dart';
import 'package:office_management/screens/location_page.dart';
import 'package:office_management/screens/news_page.dart';
import 'package:office_management/screens/people_page.dart';
import 'package:office_management/screens/service_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:office_management/service/authorize_api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user;
  int _selectedIndexPage = 0;
  PageController _pageController;
  String _title;

  final _selectedPage = [
    NewsPage(),
    ServicePage(),
    PeoplePage(),
    LocationPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
    _getSharedPreferences();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _getSharedPreferences() async {
    //TODO перенести в общий класс
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String lastUser = preferences.getString("LastUser");
    String lastToken = preferences.getString("LastToken");
    String lastEmail = preferences.getString("LastEmail");
    String lastUserId = preferences.getString("LastUserId");
    setState(() {
      user = User(lastUser, lastToken, lastEmail, lastUserId);
    });
  }

  void _onItemTapped(int page) {
   /* _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);*/
    setState(() {
      this._selectedIndexPage = page;
      /*switch (page) {
        case 0:
          _title = "Новости";
          break;
        case 1:
          _title = "Сервисы";
          break;
        case 2:
          _title = "Сотрудники";
          break;
        case 3:
          _title = "Информация";
          break;
      }*/
    });
  }

  void onPageChanged(int page) {
    setState(() {
      this._selectedIndexPage = page;
    });
  }

  _logOut() {
    requestLogoutAPI(context);
    Navigator.of(context).pushReplacementNamed('/LoginScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(""),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.signOutAlt),
              onPressed: _logOut,
            ),
          ],
        ),
        drawer: Drawer(),
        body: Container(
          color: Colors.grey[800],
          child: Center(
            child: _selectedPage.elementAt(_selectedIndexPage),
          ),/*PageView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              NewsPage(),
              ServicePage(),
              PeoplePage(),
              LocationPage()
            ],
            onPageChanged: onPageChanged,
            //controller: _pageController,
          ),*/
        ),
        bottomNavigationBar: Theme(
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
                  icon: Icon(Icons.local_laundry_service),
                  title: Text('Сервисы')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), title: Text('Сотрудники')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.info), title: Text('Информация')),
            ],
            currentIndex: _selectedIndexPage,
            //fixedColor: Colors.deepPurple,
            onTap: _onItemTapped,
          ),
        ));
  }
}
