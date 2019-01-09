import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:office_management/model/article.dart';
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String url =
      "https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=b57085cf76ae4932af4bbd9bb92ff593";
  List<Article> articles;
  bool _loadingArticleInProgress;
  bool _loadingUserInProgress;

  fetchArticle() async {
    final response = await http.get(Uri.encodeFull(url));
    setState(() {
      articles = (json.decode(response.body)['articles'] as List)
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
                  itemCount: articles == null ? 0 : articles.length,
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
