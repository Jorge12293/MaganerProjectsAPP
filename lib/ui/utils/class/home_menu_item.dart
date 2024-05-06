import 'package:flutter/material.dart';

class HomeMenuItem {
  String title;
  String tag;
  IconData icon;
  Widget item;
  HomeMenuItem(
      {required this.title,
      required this.tag,
      required this.icon,
      required this.item});
}
