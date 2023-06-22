import 'dart:convert';

import 'package:armada/models/machine.dart';
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import 'package:armada/networkhandler.dart';

import 'machineDetail_screen.dart';

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
  NetworkHandler networkHandler = NetworkHandler();
  List<MachineM> machine = [];
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/api/machinery/");

    setState(() {
      machine = (json.decode(response.body) as List)
          .map((data) => MachineM.fromJson(data))
          .toList();
    });
  }

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
              itemCount: machine.length,
              itemBuilder: (BuildContext context, int index) {
                final machines = machine[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => machineDetail(
                              machinlist: machines,
                              networkHandler: networkHandler,
                            )),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://armada-server.glitch.me/api/machinery/image/${machines.imageFile}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "FManufacturer ${machines.manufacturer}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Model: ${machines.model} - Region: ${machines.region}\' Year ${machines.year}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.thumb_up_sharp,
                                  color: Colors.green,
                                ),
                                Icon(Icons.star, color: Colors.yellow),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
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
