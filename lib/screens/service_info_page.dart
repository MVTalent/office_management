import 'package:flutter/material.dart';
import 'package:office_management/model/service.dart';

class ServiceInfoPage extends StatelessWidget {

  ServiceInfoPage(this.data);

  final Service data;

  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(title: new Text('Информация о ' + data.name)),
      body: data.build(context)
  );

}