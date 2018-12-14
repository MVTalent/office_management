import 'package:flutter/material.dart';

class PeopleInfoPage extends StatelessWidget {
  PeopleInfoPage(this.data);

  final data;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: new Text('Информация о пользователе')),
      body: Column(
        children: <Widget>[
          Center(
            child: new Container(
              width: 150.0,
              height: 150.0,
              decoration: new BoxDecoration(
                color: const Color(0xff7c94b6),
                image: new DecorationImage(
                  image: new NetworkImage(data["picture"]["large"]),
                  fit: BoxFit.cover,
                ),
                borderRadius: new BorderRadius.all(new Radius.circular(75.0)),
                border: new Border.all(
                  color: Colors.red,
                  width: 4.0,
                ),
              ),
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(30.0),
            child: Table(
              children: [
                TableRow(
                    children: [
                      TableCell(
                        child: Text("Фамилия"),
                      ),
                      TableCell(
                        child: Text(data["name"]["last"]),
                      ),
                    ]),
                TableRow(children: [
                  TableCell(
                    child: Text("Имя"),
                  ),
                  TableCell(
                    child: Text(data["name"]["first"]),
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                    child: Text("Пол"),
                  ),
                  TableCell(
                    child: Text(data["gender"]),
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                    child: Text("E-mail"),
                  ),
                  TableCell(
                    child: Text(data["email"]),
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                    child: Text("Телефон"),
                  ),
                  TableCell(
                    child: Text(data["phone"]),
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                    child: Text(
                      "Аккаунт",
                    ),
                  ),
                  TableCell(
                    child: Text(data["login"]["username"]),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ));

  TextStyle tableTextStyle() {
    return TextStyle(fontWeight: FontWeight.w400, fontSize: 20);
  }
}
