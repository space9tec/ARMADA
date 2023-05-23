import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class AddFarm extends StatefulWidget {
  static const String routeName = '/add_farm';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => AddFarm(),
    );
  }

  const AddFarm({super.key});

  @override
  State<AddFarm> createState() => _AddFarmState();
}

class _AddFarmState extends State<AddFarm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/display_notification');
            },
            icon: Icon(Icons.notifications_sharp),
          ),
        ],
      ),
      drawer: navigationDrawer(),
      // bottom navbar
      bottomNavigationBar: bottomAppbar(context),
    );
  }
}
