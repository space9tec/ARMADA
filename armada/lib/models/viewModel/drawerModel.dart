import 'package:flutter/material.dart';

class DrawerModel {
  String title;
  IconData icon;
  late Action onSelection;

  DrawerModel({required this.title, required this.icon});
}

List<DrawerModel> DrawerItem = [
  DrawerModel(icon: Icons.home, title: "Profile"),
  DrawerModel(icon: Icons.check, title: "Farm"),
  DrawerModel(icon: Icons.person, title: "Profile"),
];
