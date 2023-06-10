import 'package:flutter/material.dart';

import 'package:armada/models/viewModel/drawerModel.dart';

import '../../widgets/widgets.dart';

class MachineScreen extends StatefulWidget {
  static const String routeName = '/machie_screen';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => MachineScreen(),
    );
  }

  const MachineScreen({super.key});

  @override
  State<MachineScreen> createState() => _MachineScreenState();
}

class _MachineScreenState extends State<MachineScreen> {
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
            Navigator.pushNamed(context, '/AddMachine');
          },
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: ServiceProvidernavigationDrawer(),
      // bottom navbar
      bottomNavigationBar: ServiceProviderbottomAppbar(context),
    );
  }
}
