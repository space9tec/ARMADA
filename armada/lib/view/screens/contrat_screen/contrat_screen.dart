import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

import '../../../models/model.dart';
import '../../../networkhandler.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class ContractList extends StatefulWidget {
  final String contractstatus;
  const ContractList(this.contractstatus, {super.key});

  @override
  State<ContractList> createState() => _ContractListState();
}

class _ContractListState extends State<ContractList> {
  NetworkHandler networkHandler = NetworkHandler();
  final storage = const FlutterSecureStorage();

  List<ContractsModel> contract = [];
  MachineM? machine;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<dynamic> filteredData = [];

    String? userJson = await storage.read(key: 'userm');
    UserModel usermode = UserModel.fromJson(json.decode(userJson!));

    var response = await networkHandler.get("/api/contracts/${usermode.useid}");

    List<dynamic> responseData = json.decode(response.body);

    if (widget.contractstatus == "received") {
      if (mounted) {
        setState(() {
          filteredData = responseData
              .where((data) => (data['owner_id'] == usermode.useid))
              .toList();
        });
      }
    } else if (widget.contractstatus == "sent") {
      if (mounted) {
        setState(() {
          filteredData = responseData
              .where((data) => (data['user_id'] == usermode.useid))
              .toList();
        });
      }
    }

    if (mounted) {
      setState(() {
        contract =
            filteredData.map((data) => ContractsModel.fromJson(data)).toList();
      });
    }
  }

  @override
  void dispose() {
    contract.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contract.length,
      itemBuilder: (BuildContext context, int index) {
        final contracts = contract[index];
        return FutureBuilder(
          future: _getMachineData(contracts.machineId),
          builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              Map<String, dynamic> machineData =
                  json.decode(snapshot.data!.body);
              MachineM machine = MachineM.fromJson(machineData["machinery"]);

              return _buildContractCard(contracts, machine, context);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return PreloadWidget();
            }
            return PreloadWidget();
          },
        );
      },
    );
  }

  Future<Response> _getMachineData(String machineId) async {
    var response = await networkHandler.get("/api/machinery/$machineId");
    return response;
  }

  Color _getBorderColor(String status) {
    switch (status) {
      case "Accepted":
        return Color.fromARGB(
            255, 222, 253, 223); // Set the border color for the accepted status
      case "In Progress":
        return const Color.fromARGB(
            255, 253, 251, 229); // Set the border color for the pending status
      case "Rejected":
        return const Color.fromARGB(
            255, 250, 226, 224); // Set the border color for the rejected status
      default:
        return Colors.transparent; // Set a default border color if needed
    }
  }

  String formatDate(DateTime date) {
    final DateFormat formatter =
        DateFormat('dd MMMM yyyy'); // Define your desired format here
    return formatter.format(date);
  }

  Widget _buildContractCard(
      ContractsModel contracts, MachineM machine, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => ItemPage(
                    contractsModel: contracts,
                    machineid: contracts.machineId,
                  )),
            ),
          );
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.13,
          // width: MediaQuery.of(context).size.width * 0.8,
          child: Card(
            color: _getBorderColor(contracts.status),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: _getBorderColor(contracts.status), width: 1),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.095,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.02)),
                        color: Colors.black.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(12)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          fit: BoxFit.cover,
                          "https://armada-server.glitch.me/api/machinery/image/${machine.imageFile}",
                        )),
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(machine.type),
                          // Text(machine.model),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Duration"),
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width * 0.6,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.02)),
                                    color: Colors.black.withOpacity(0.04),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  children: [
                                    Icon(Icons.access_time_rounded),
                                    Expanded(
                                      child: Text(
                                        // String formattedDate = formatDate(myDate);
                                        "${formatDate(DateTime.parse(contracts.rent_start_time))} - ${formatDate(DateTime.parse(contracts.rent_end_time))}",
                                        // overflow: TextOverflow.ellipsis,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.009,
                      right: MediaQuery.of(context).size.width * 0.01,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Text(contracts.status),
                      ),
                    )
                  ],
                ),
              ],
            ),
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     ListTile(
            //       leading: CircleAvatar(
            //           backgroundImage: NetworkImage(
            //               "https://armada-server.glitch.me/api/machinery/image/${machine.imageFile}")),
            //       title: Text(machine.manufacturer),
            //       subtitle: Text("${contracts.status}"),
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}

class ContractPage extends StatefulWidget {
  static const String routeName = '/contrat_page';

  const ContractPage({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return const ContractPage();
      },
    );
  }

  @override
  ContractPageState createState() => ContractPageState();
}

class ContractPageState extends State<ContractPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  NetworkHandler networkHandler = NetworkHandler();
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchuserid();
  }

  UserModel usermode = const UserModel(
      firstname: '',
      password: '',
      lastname: '',
      phone: '',
      useid: '',
      image: '');

  void fetchuserid() async {
    String? userJson = await storage.read(key: 'userm');

    if (userJson != null) {
      // Convert JSON to UserModel
      setState(() {
        usermode = UserModel.fromJson(json.decode(userJson));
      });
    } else {
      print("empity");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Contracts"),
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
          tabs: const [
            Tab(text: 'Sent'),
            Tab(text: 'Received'),
          ],
          // indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3, indicatorColor: Colors.white,
          labelColor: Colors.white,
          labelStyle:
              const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ContractList("sent"),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ContractList("received"),
          ),
        ],
      ),
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

class PreloadWidget extends StatelessWidget {
  const PreloadWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      // width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.13,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                _Skelton(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.095,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Skelton(width: 50),
                    SizedBox(
                      height: 10,
                    ),
                    Skelton(width: 40),
                    SizedBox(
                      height: 5,
                    ),
                    Skelton(
                      width: 180,
                      height: 25,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
