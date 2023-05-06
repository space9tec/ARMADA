import 'package:flutter/material.dart';

class DrawerModel {
  String title;
  IconData icon;
  late Action onSelection;

  DrawerModel({required this.title, required this.icon});
}

List<DrawerModel> DrawerItem = [
  DrawerModel(icon: Icons.home, title: "Home"),
  DrawerModel(icon: Icons.check, title: "Market"),
  DrawerModel(icon: Icons.person, title: "Profile"),
  DrawerModel(icon: Icons.person, title: "Profile"),
];
