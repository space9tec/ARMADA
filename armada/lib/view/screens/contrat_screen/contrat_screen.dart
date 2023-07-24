import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

import '../../../models/contracts.dart';
import '../../../models/machine.dart';
import '../../../networkhandler.dart';
import '../screens.dart';

class ContractList extends StatefulWidget {
  String contractstatus;
  ContractList(this.contractstatus, {super.key});

  @override
  State<ContractList> createState() => _ContractListState();
}

class _ContractListState extends State<ContractList> {
  NetworkHandler networkHandler = NetworkHandler();
  final storage = new FlutterSecureStorage();

  List<ContractsModel> contract = [];
  // List<Machine> contract = [];
  MachineM? machine;

  @override
  void initState() {
    super.initState();
    fetchData();
    // fetchMachine();
  }

  void fetchData() async {
    String? tok = await storage.read(key: "userid");

    var response = await networkHandler.get("/api/contracts/${tok}");
    print(response.body);
    List<dynamic> responseData = json.decode(response.body);

    List<dynamic> filteredData = responseData
        .where((data) =>
            data['status'] == widget.contractstatus &&
            (data['user_id'] == tok || data['owner_id'] == tok))
        .toList();

    // var responsem = await networkHandler.get("/api/machinery/");
    //   print(response);
    // Map<String, dynamic> machineData = json.decode(responsem.body);
    setState(() {
      contract =
          filteredData.map((data) => ContractsModel.fromJson(data)).toList();
      // machine = MachineM.fromJson(machineData);
    });
  }
  //  void fachemachine() async {
  //   // try {
  //   var response = await networkHandler.get("/api/machinery/");
  //   print(response);
  //   Map<String, dynamic> machineData = json.decode(response.body);
  //   print(machineData);

  //   setState(() {
  //     machine = MachineM.fromJson(machineData);
  //     fetched = true;
  //   });

  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contract.length,
      itemBuilder: (context, index) {
        final contracts = contract[index];
        return FutureBuilder(
          future: _getMachineData(contracts.machineId),
          builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              Map<String, dynamic> machineData =
                  json.decode(snapshot.data!.body);
              MachineM machine = MachineM.fromJson(machineData);
              return _buildContractCard(contracts, machine, context);
            }
            return Container(); // or any other loading indicator
          },
        );
      },
    );
  }

  Future<Response> _getMachineData(String machineId) async {
    var response = await networkHandler.get("/api/machinery/$machineId");
    return response;
  }

  Widget _buildContractCard(
      ContractsModel contracts, MachineM machine, BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, '/contrat_detail');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => ContractDetailPage(
                  contractlist: contracts,
                )),
          ),
        );
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.23,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xFF006837), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://armada-server.glitch.me/api/machinery/image/${machine.imageFile}")),
                title: Text(machine.manufacturer),
                subtitle: Text("${machine.year}"),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Start date: ${contracts.rent_start_time}",
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8.0),
                        Text("End date: ${contracts.rent_end_time}",
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8.0),
                        Text(contracts.status),
                      ],
                    ),
                  ),
                ],
              ),
            ],
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
  _ContractPageState createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
            icon: const Icon(Icons.notifications_sharp),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Accepted'),
            Tab(text: 'Rejected'),
          ],
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3,
          labelColor: Colors.white,
          labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ),
      // body: Column(

      body: TabBarView(
        controller: _tabController,
        children: [
          ContractList("In Progress"),
          ContractList("Accepted"),
          ContractList("Rejected")
        ],
      ),
    );
  }
}
