import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  static const String routeName = '/help';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => Help(),
    );
  }

  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Help"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
