import 'package:flutter/material.dart';

class TermandCondition extends StatelessWidget {
  static const String routeName = '/TermsandConditions';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => TermandCondition(),
    );
  }

  const TermandCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text("Terms & Conditions"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(),
    );
  }
}
