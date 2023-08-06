import 'dart:convert';

import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../models/model.dart';
import '../../../networkhandler.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class PropertyScreen extends StatefulWidget {
  static const String routeName = '/owneritem';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const PropertyScreen(),
    );
  }

  const PropertyScreen({super.key});

  @override
  State<PropertyScreen> createState() => PropertyScreenState();
}

class PropertyScreenState extends State<PropertyScreen>
    with SingleTickerProviderStateMixin {
  NetworkHandler networkHandler = NetworkHandler();
  final storage = const FlutterSecureStorage();
  late TabController _tabController;
  List<FarmM> farm = [];
  List<MachineM> machine = [];

  bool fatched = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/api/farm/");

    String? userJson = await storage.read(key: 'userm');
    UserModel usermode = UserModel.fromJson(json.decode(userJson!));

    List<dynamic> responseData = json.decode(response.body);

    List<dynamic> filteredData = responseData
        .where((data) => data['owner_id'] == usermode.useid)
        .toList();
    if (mounted) {
      setState(() {
        farm = filteredData.map((data) => FarmM.fromJson(data)).toList();
        fatched = true;
      });
    }

    var responseM = await networkHandler.get("/api/machinery/");
    // String? ownerid = await storage.read(key: "userid");
    List<dynamic> responseMData = json.decode(responseM.body);

    List<dynamic> filteredMData = responseMData
        .where((data) => data['owner_id'] == usermode.useid)
        .toList();

    setState(() {
      machine = filteredMData.map((data) => MachineM.fromJson(data)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/display_notification');
            },
            icon: const Icon(Icons.notifications_sharp),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
                child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.landscape),
                addHorizontalSpace(10),
                Text('Farm')
              ],
            )),
            Tab(
              text: 'Machines',
            ),
          ],
          // indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          labelStyle:
              const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          fatched
              ? ListView.builder(
                  itemCount: farm.length,
                  itemBuilder: (BuildContext context, int index) {
                    final farms = farm[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => farmDetail(
                                  farmlist: farms,
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
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            color: Colors.black.withOpacity(0.04),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://armada-server.glitch.me/api/farm/image/${farms.imagename}"),
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
                                      "Farm Name: ${farms.farmname}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Farm Size: ${farms.farmsize} - Location:\' ${farms.longtude}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const _PreloadWidget(),
          // Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: ContractList("Machinerys"),
          // ),
          ListView.builder(
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
        ],
      ),
      // body: Column(children: [
      //   CustomBinaryOption(
      //     textLeft: "All",
      //     textRight: "Booked",
      //   ),
      // ]),
      drawer: navigationDrawer(),
      bottomNavigationBar: bottomAppbar(context),
    );
  }
}

class _Skelton extends StatelessWidget {
  final double? height, width;
  const _Skelton({key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}

class _PreloadWidget extends StatelessWidget {
  const _PreloadWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        InkWell(
          onTap: () {},
          child: Column(
            children: [
              Row(
                children: [
                  _Skelton(
                    width: MediaQuery.of(context).size.width * 0.97,
                    height: MediaQuery.of(context).size.height * 0.19,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  _Skelton(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  _Skelton(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  _Skelton(
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  _Skelton(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
