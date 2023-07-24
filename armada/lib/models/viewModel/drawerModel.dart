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
  DrawerModel(icon: Icons.car_repair_rounded, title: "Machinery"),
  DrawerModel(icon: Icons.person, title: "About"),
];
List<DrawerModel> gustDrawerItem = [
  DrawerModel(icon: Icons.home, title: "Home"),
  DrawerModel(icon: Icons.person, title: "Sign up"),
  DrawerModel(icon: Icons.info, title: "About"),
];

List<DrawerModel> BDrawerItem = [
  DrawerModel(icon: Icons.settings, title: "Setting"),
  DrawerModel(icon: Icons.help, title: "Help"),
  DrawerModel(icon: Icons.logout, title: "Logout"),
];
List<DrawerModel> gustBDrawerItem = [
  DrawerModel(icon: Icons.settings, title: "Setting"),
  DrawerModel(icon: Icons.help, title: "Help"),
  DrawerModel(icon: Icons.contact_page_outlined, title: "Contact us"),
];
List<DrawerModel> ServiceProviderDrawerItem = [
  DrawerModel(icon: Icons.settings, title: "Profile"),
  DrawerModel(icon: Icons.car_repair_rounded, title: "Machinery"),
  DrawerModel(icon: Icons.settings, title: "About"),
];
// "message":"E11000 duplicate key error collection: armada.farms index: farm_name_1 dup key: { farm_name: \"farmland\" }"}