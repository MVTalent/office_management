import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;
  bool _loadingInProgress;

  StreamSubscription<Map<String, double>> _locationSubscription;

  Location _location = new Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;

  Image image1;

  @override
  void initState() {
    super.initState();

    _loadingInProgress = true;

    initPlatformState();

    _locationSubscription =
        _location.onLocationChanged().listen((Map<String, double> result) {
      setState(() {
        _currentLocation = result;
        _loadingInProgress = false;
      });
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    Map<String, double> location;
    try {
      _permission = await _location.hasPermission();
      location = await _location.getLocation();
      setState(() {
        _startLocation = location;
      });

      error = null;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return _loadingInProgress == true
        ? new Center(
            child: CircularProgressIndicator(),
          )
        : new Scaffold(
            //appBar: AppBar(title: new Text('Leaflet Maps')),
            body: new FlutterMap(
              options: new MapOptions(
                  center: new LatLng(_currentLocation["latitude"],
                      _currentLocation["longitude"]),
                  minZoom: 10.0),
              layers: [
                new TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']),
                new MarkerLayerOptions(
                  markers: [
                    new Marker(
                      width: 45.0,
                      height: 45.0,
                      point: new LatLng(_currentLocation["latitude"],
                          _currentLocation["longitude"]),
                      builder: (context) => new Container(
                            child: IconButton(
                              icon: Icon(Icons.location_on),
                              color: Colors.blue,
                              iconSize: 45.0,
                              onPressed: () {
                                print('Marker tapped');
                              },
                            ),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
