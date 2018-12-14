import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:office_management/screens/people_info_page.dart';

class PeoplePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  String url = 'https://randomuser.me/api/?results=15';
  List data;

  Future<String> getUsers() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var extractdata = json.decode(response.body);
      data = extractdata["results"];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, i) {
              return Card(
                color: Colors.blue,
                child: ListTile(
                  title: Text(data[i]["name"]["first"], style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white,),),
                  subtitle: Text(data[i]["phone"], style: TextStyle(color: Colors.white,),),
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(data[i]["picture"]["thumbnail"]),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PeopleInfoPage(data[i])));
                  },
                ),
              );
            }));
  }
}
