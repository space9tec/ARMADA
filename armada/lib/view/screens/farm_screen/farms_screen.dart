import 'package:flutter/material.dart';

import 'package:armada/models/viewModel/drawerModel.dart';

import '../../widgets/widgets.dart';

class FarmScreen extends StatefulWidget {
  static const String routeName = '/farm_screen';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => FarmScreen(),
    );
  }

  const FarmScreen({super.key});

  @override
  State<FarmScreen> createState() => _FarmScreenState();
}

class _FarmScreenState extends State<FarmScreen> {
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    height: 150,
                    decoration: BoxDecoration(color: Colors.green),
                  ),
                );
              },
            ),
          ),
          Text("data"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add_farm1');
          },
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: navigationDrawer(),
      // bottom navbar
      bottomNavigationBar: bottomAppbar(context),
    );
  }
}
