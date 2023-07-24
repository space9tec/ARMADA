import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1 / 1,
      children: List.generate(
        contract.length,
        (index) {
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
              }
              return Container();
            },
          );
        },
      ),
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
        height: MediaQuery.of(context).size.height * 0.13,
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
                        Text(
                            "Start date: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(contracts.rent_start_time))}",
                            style: const TextStyle(
                                fontSize: 10.0, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8.0),
                        Text(
                            "End date: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(contracts.rent_end_time))}",
                            style: const TextStyle(
                                fontSize: 10.0, fontWeight: FontWeight.bold)),
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
          indicatorWeight: 3,
          labelColor: Colors.white,
          labelStyle:
              const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ContractList("sent"),
          ContractList("received"),
        ],
      ),
      drawer: navigationDrawer(),
      bottomNavigationBar: bottomAppbar(context),
    );
  }
}
