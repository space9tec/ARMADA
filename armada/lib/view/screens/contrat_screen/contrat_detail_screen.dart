import 'dart:convert';

import 'package:armada/models/contracts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/machine.dart';
import '../../../networkhandler.dart';

import '../../../provider/drop_down_provider.dart';

class ContractDetailPage extends StatefulWidget {
  const ContractDetailPage({
    super.key,
    required this.contractlist,
  });
  final ContractsModel contractlist;

  @override
  State<ContractDetailPage> createState() => _ContractDetailPageState();
}

class _ContractDetailPageState extends State<ContractDetailPage> {
  NetworkHandler networkHandler = NetworkHandler();
  MachineM? machine;
  bool fetched = false;
  // List<MachineM> machinery = [];
// var responseJson = json.decode(response);
//     machine = Machine.fromJson(responseJson);
  @override
  void initState() {
    super.initState();
    fachemachine(widget.contractlist.machineId);
    // facheuser();
  }

  void fachemachine(String machinid) async {
    // try {
    var response = await networkHandler.get("/api/machinery/${machinid}");
    print(response);
    Map<String, dynamic> machineData = json.decode(response.body);
    print(machineData);

    setState(() {
      machine = MachineM.fromJson(machineData);
      fetched = true;
    });
    // List<dynamic> responseData = json.decode(response.body);

    // List<dynamic> filteredData =
    //     responseData.where((data) => data['_id'] == machinid).toList();
    // print("fach");

    // print(filteredData);
    // print("fached");
    // print(response.body);
    // print(machinery);
    // } catch (e) {
    //   print(e);
    // }
    // List<dynamic> responseData = json.decode(response.body);
// const machineData = response.data[0];

    // print("fached");
    // print(response.body);
    // print(machinery);
    // setState(() {
    //   machinery = filteredData.map((data) => MachineM.fromJson(data)).toList();
    // });
    // Map<String, dynamic> output = json.decode(response.body);
    // // dynamic filteredData =
    // //     responseData.where((data) => data['_id'] == machinid);

    // setState(() {
    //   machine = output as MachineM;
    // });
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
              Provider.of<DropDownProvider>(context, listen: false)
                          .selectedAccount ==
                      'Farmer'
                  ? Navigator.pushNamed(context, '/contractedit')
                  : null;
            },
            icon: Provider.of<DropDownProvider>(context, listen: false)
                        .selectedAccount ==
                    'Service Provider'
                ? Icon(Icons.share)
                : Icon(Icons.edit),
          ),
        ],
      ),
      body: fetched
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/tracter1.png'),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              'Owner: ${machine!.manufacturer}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.network(
                                "https://armada-server.glitch.me/api/machinery/image/${machine!.imageFile}",
                                height:
                                    MediaQuery.of(context).size.height * 0.25),
                            width: MediaQuery.of(context).size.width * 0.85,
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Contract Start Date: ${widget.contractlist.rent_start_time}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Contract End Date: ${widget.contractlist.rent_end_time}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Provider.of<DropDownProvider>(context, listen: false)
                                    .selectedAccount ==
                                'Service Provider'
                            ? Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Color(0xFF006837),
                                          ),
                                        ),
                                        child: const Text(
                                          'Confirm Contract',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Color(0xFF006837),
                                          ),
                                        ),
                                        child: const Text(
                                          'Start Message',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator(color: Color(0xFF006837))),
    );
  }
}
