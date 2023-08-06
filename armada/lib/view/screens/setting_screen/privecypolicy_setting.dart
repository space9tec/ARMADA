import 'package:flutter/material.dart';

class PrivecyPolicy extends StatelessWidget {
  static const String routeName = '/privecyPolicy';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => PrivecyPolicy(),
    );
  }

  const PrivecyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("privacy policy"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(),
    );
  }
}
