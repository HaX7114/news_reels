import 'package:flutter/material.dart';

class DrawerObjects{
  String name;
  dynamic icon;
  dynamic color;
  String newsAPIElement;//This may be category or country

  DrawerObjects({required this.name,required this.icon,this.color,required this.newsAPIElement});
}