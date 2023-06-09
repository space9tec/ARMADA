import 'package:flutter/material.dart';

class DrawerModel {
  String title;
  IconData icon;
  late Action onSelection;

  DrawerModel({required this.title, required this.icon});
}

List<DrawerModel> DrawerItem = [
  DrawerModel(icon: Icons.person, title: "Profile"),
  DrawerModel(icon: Icons.landscape, title: "Farm"),
  DrawerModel(icon: Icons.person, title: "Profile"),
];

List<DrawerModel> BDrawerItem = [
  DrawerModel(icon: Icons.settings, title: "Setting"),
  DrawerModel(icon: Icons.help, title: "Help"),
  DrawerModel(icon: Icons.logout, title: "Logout"),
];
List<DrawerModel> ServiceProviderDrawerItem = [
  DrawerModel(icon: Icons.settings, title: "Profile"),
  DrawerModel(icon: Icons.car_repair_rounded, title: "Machinery"),
  DrawerModel(icon: Icons.logout, title: "Logout"),
];
