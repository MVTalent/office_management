import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:office_management/model/article.dart';
import 'package:http/http.dart' as http;
import 'package:office_management/service/rest_client.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String url =
      "https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=b57085cf76ae4932af4bbd9bb92ff593";
  List<Article> articles;

  Future<List<Article>> fetchArticle() async {
    final response = await http.get(Uri.encodeFull(url));
    setState(() {
      articles = (json.decode(response.body)['articles'] as List)
          .map((e) => Article.fromJson(e))
          .toList();
    });
    return articles;
  }

  @override
  void initState() {
    super.initState();
    this.fetchArticle();
  }

  @override
  void dispose() {
    super.dispose();
  }

/*
  List<Article> parseArticle(String responseBody) {
    //final parsed = (json.decode(responseBody) as List) .cast<Map<dynamic, dynamic>>();

    return (json.decode(responseBody)['articles'] as List)
        .map((e) => Article.fromJson(e))
        .toList();
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: articles == null ? 0 : articles.length,
                  itemBuilder: (BuildContext context, i) {
                    if (articles == null || articles.length == 0) {
                      return CircularProgressIndicator();
                    } else {
                      return Container(
                        width: 250,
                        child: Card(
                            color: Colors.purple[100],
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
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    subtitle: Text(
                                      articles[i].description != null
                                          ? articles[i].description
                                          : "",
                                      style: TextStyle(fontSize: 8),
                                    ),
                                  ),
                                  /*ButtonTheme.bar(
                            // make buttons use the appropriate styles for cards
                            child: ButtonBar(
                              children: <Widget>[
                                FlatButton(
                                  child: const Text('Просмотреть'),
                                  onPressed: () {},
                                ),
                                FlatButton(
                                  child: const Text('Закрыть'),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),*/
                                ],
                              ),
                            )),
                      );
                    }
                  })),
          Container(
            //margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 150,
            child: Card(
                color: Colors.greenAccent,
                child: Center(
                  child: ListTile(
                    leading: Icon(
                      Icons.account_box,
                      size: 80,
                    ),
                    title: Text(
                      "Информация о пользователе",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      "Иванов Иван Иванович",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                )),
          )
        ],
      ),
    ));
  }
}
