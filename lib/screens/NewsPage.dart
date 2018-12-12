import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:office_management/model/Article.dart';
import 'package:http/http.dart' as http;

Future<List<Article>> fetchArticle() async {
  final response = await http.get(
      'https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=b57085cf76ae4932af4bbd9bb92ff593');
  return compute(parseArticle, response.body);
}

List<Article> parseArticle(String responseBody) {
  //final parsed = (json.decode(responseBody) as List) .cast<Map<dynamic, dynamic>>();

  return (json.decode(responseBody)['articles'] as List)
      .map((e) => Article.fromJson(e))
      .toList();
}

class NewsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<List<Article>>(
          future: fetchArticle(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              //leading: Icon(Icons.album),
                              leading: Image.network('${snapshot.data[index].urlToImage}', width: 120, height: 120),
                              title: Text('${snapshot.data[index].title}'),
                              subtitle: Text('${snapshot.data[index].description}'),
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
                  }
              );
            } else if (snapshot.hasError) {
              return Text("$snapshot.error");
            }
            return CircularProgressIndicator();
          },
        )
    );
   /* return Container(
      height: 200,
      padding: EdgeInsets.all(20.0),
      child: ListView(scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 160,
            //child: Center(
              child: Card(
                child: ListTile(
                  title: Text("Новость №1"),
                ),
              ),
            //),
          ),
          Container(
            width: 160,
            //child: Center(
              child: Card(
                child: ListTile(
                  title: Text("Новость №1"),
                ),
              ),
            //),
          ),
          Container(
            width: 160,
            //child: Center(
              child: Card(
                child: ListTile(
                  title: Text("Новость №1"),
                ),
              ),
            //),
          )
        ],),
    );*/
    /*children: <Widget>[
          new ListTile(leading: new Icon(Icons.info),
              onTap:(){}
          ),
          new ListTile(leading: new Icon(Icons.save),
              onTap:(){}
          ),
        ],
      );*/
  }

}