import 'package:flutter/material.dart';
import 'package:office_management/model/service/negotiation_service.dart';
import 'package:office_management/model/service/rest_room_service.dart';
import 'package:office_management/model/service.dart';
import 'package:office_management/model/service/skud_service.dart';
import 'package:office_management/screens/service_info_page.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  List<Service> services = [
    SKUDService(name: "СКУД", description: "Информация о СКУД"),
    NegotiationService(
        name: "\"Переговорая\"",
        description: "Информация о переговорной комнате"),
    RestRoomService(
        name: "Комната отдыха", description: "Информация о комнате отдыха"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Внутренние сервисы',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      //margin: EdgeInsets.only(right: 10.0, left: 10.0),
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: services == null ? 0 : services.length,
                          itemBuilder: (BuildContext context, i) {
                            if (services == null || services.length == 0) {
                              return CircularProgressIndicator();
                            } else {
                              return Container(
                                width: 230,
                                child: Card(
                                  color: Colors.blue,
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          leading: Icon(Icons.category),
                                          title: Text(
                                            services[i].name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          subtitle: Text(
                                            services[i].description,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ServiceInfoPage(
                                                            services[i])));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Внутренние сервисы',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      //margin: EdgeInsets.only(right: 10.0, left: 10.0),
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: services == null ? 0 : services.length,
                          itemBuilder: (BuildContext context, i) {
                            if (services == null || services.length == 0) {
                              return CircularProgressIndicator();
                            } else {
                              return Container(
                                width: 230,
                                child: Card(
                                  color: Colors.blue,
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          leading: Icon(Icons.category),
                                          title: Text(
                                            services[i].name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          subtitle: Text(
                                            services[i].description,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                    context) =>
                                                        ServiceInfoPage(
                                                            services[i])));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        //padding: const EdgeInsets.all(10.0),
      ),
    );
  }
}
