import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:office_management/model/service.dart';

class SKUDService extends Service {
  SKUDService({String name, String description})
      : super(name: name, description: description);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          padding: const EdgeInsets.all(8.0),
          textColor: Colors.white,
          color: Colors.blue,
          child: Text("Открыть"),
          onPressed: () => () {
                print("СКУД открыт");
              },
        ),
        RaisedButton(
          padding: const EdgeInsets.all(8.0),
          textColor: Colors.white,
          color: Colors.red,
          child: Text("Закрыть"),
          onPressed: () => () {
                print("СКУД закрыт");
              },
        ),
      ],
    );
  }
}
