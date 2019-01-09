import 'package:flutter/material.dart';
import 'package:office_management/screens/location_page.dart';
import 'package:office_management/screens/news_page.dart';
import 'package:office_management/screens/people_page.dart';
import 'package:office_management/screens/service_page.dart';

@deprecated
abstract class LoadingBaseState<T extends StatefulWidget> extends State<T> {
  String _title = "";
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
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: new AppBar(
          title: new Text(_title),
          actions: <Widget>[
            FlatButton(
                onPressed: _logOut,
                child: new Text(
                  "Выход",
                  style: new TextStyle(color: Colors.white),
                )),
          ],
        ),
        drawer: Drawer(),
        body: PageView(
          children: <Widget>[
            NewsPage(),
            ServicePage(),
            PeoplePage(),
            LocationPage()
          ],
          onPageChanged: onPageChanged,
          controller: _pageController,
        ),
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
                  icon: Icon(Icons.local_laundry_service),
                  title: Text('Сервисы')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), title: Text('Сотрудники')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.info), title: Text('Информация')),
            ],
            currentIndex: _page,
            //fixedColor: Colors.deepPurple,
            onTap: _onItemTapped,
          ),
        ),
      );

  Widget content();

  /*set isLoading(bool value) {
    _isLoading = value;
  }

  set title(String value) {
    _title = value;
  }

  set hasUser(bool value) {
    _hasUser = value;
  }*/

  void _logOut() {
    /*var dialog = DialogShower.buildDialog(
        title: "Leaving?",
        message: "Are you sure you want to log out?",
        confirm: "Yes",
        confirmFn: () {
          setState(() => _isLoading = true);
          Navigator.pop(context);
          UserAuth.logout().then((n) {
            setState(() => _hasUser = false);
            setState(() => _isLoading = false);
            Navigator.of(context).pushNamedAndRemoveUntil(
                "/signin", (Route<dynamic> route) => false);
          });
        },
        cancel: "No",
        cancelFn: () => Navigator.pop(context));
    showDialog(context: context, child: dialog);*/
  }
}
