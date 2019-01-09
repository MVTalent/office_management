import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:office_management/model/article.dart';
import 'package:http/http.dart' as http;
import 'package:office_management/model/user.dart';
import 'package:office_management/service/rest_client.dart';
import 'package:office_management/service/rest_client.dart';
import 'package:office_management/service/shared_preferences_service_impl.dart';
import 'package:office_management/service/shared_storage.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String _url =
      "https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=b57085cf76ae4932af4bbd9bb92ff593";
  List<Article> articles;
  bool _loadingArticleInProgress;
  bool _loadingUserInProgress;
  List<Article> _articles;
  User _user;
  bool _loading = true;

  fetchArticle() async {
    final response = await http.get(Uri.encodeFull(_url));
    setState(() {
      _articles = (json.decode(response.body)['articles'] as List)
          .map((e) => Article.fromJson(e))
          .toList();
      _loadingArticleInProgress = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadingArticleInProgress = true;
    _loadingUserInProgress = true;
    fetchArticle();
    getUser().then((user) => setState(() {
      _user = user;
      _loading = false;
    }));
  }

  Future getUser() async {
    SharedStorage sharedStorage = SharedPreferencesStorageImpl();
    return sharedStorage.getUserFromStorage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[800],
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 200,
              child: _loadingArticleInProgress == true ? Center(child: CircularProgressIndicator(),) : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _articles == null ? 0 : _articles.length,
                  itemBuilder: (BuildContext context, i) {
                    if (articles == null || articles.length == 0) {
                      return CircularProgressIndicator();
                    } else {
                      return Container(
                        width: 250,
                        child: Card(
                            color: Colors.blue,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: articles[i].urlToImage != null
                                        ? CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                articles[i].urlToImage))
                                        : Icon(Icons.art_track, size: 60),
                                    title: Text(
                                      articles[i].title,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      articles[i].description != null
                                          ? articles[i].description
                                          : "",
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      );
                    }
                  }),
            ),
            Container(
              //margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 150,
              child: Card(
                color: Colors.blue,
                child: Center(
                  child: ListTile(
                    leading: Icon(
                      Icons.account_box,
                      size: 80,
                    ),
                    title: Text(
                      "Информация о пользователе",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    subtitle: Text(
                      "Иванов Иван Иванович",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
