import 'package:flutter/material.dart';

abstract class Service {
  final String name;
  final String description;

  Service({this.name, this.description});

  Widget build(BuildContext context);

}