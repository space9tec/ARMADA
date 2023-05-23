import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class DisplayNotification extends StatefulWidget {
  static const String routeName = '/display_notification';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => DisplayNotification(),
    );
  }

  const DisplayNotification({super.key});

  @override
  State<DisplayNotification> createState() => _DisplayNotificationState();
}

class _DisplayNotificationState extends State<DisplayNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),

      // bottom navbar
      bottomNavigationBar: bottomAppbar(context),
    );
  }
}
