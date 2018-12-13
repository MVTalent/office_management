import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:office_management/model/Article.dart';
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  String url = "https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=b57085cf76ae4932af4bbd9bb92ff593";
  List<Article> articles;

  Future<List<Article>> fetchArticle() async {
    final response = await http.get(Uri.encodeFull(url));
    setState(() {
      var extractdata = json.decode(response.body);
      for (var i = 0; i < (extractdata["articles"] as List).length; i++) {
        articles.add((extractdata["articles"] as List)[i] as Article);
      }
    });
    return articles;
  }

  @override
  void initState() {
    super.initState();
    this.fetchArticle();
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
        body: ListView.builder(
            itemCount: articles == null ? 0 : articles.length,
            itemBuilder: (BuildContext context, i) {
              return Center(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        //leading: Icon(Icons.album),
                        leading: Image.network(
                            articles[i].urlToImage, width: 120, height: 120),
                        title: Text(articles[i].title),
                        subtitle: Text(articles[i].description),
                      ),
                      ButtonTheme.bar(
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
                      ),
                    ],
                  ),
                ),
              );
            })
    );
  }
}
