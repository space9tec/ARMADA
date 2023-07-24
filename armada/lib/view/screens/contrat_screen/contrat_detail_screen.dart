import 'dart:convert';

import 'package:armada/models/contracts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/conversation.dart';
import '../../../models/machine.dart';
import '../../../models/user.dart';
import '../../../networkhandler.dart';

import '../../../provider/drop_down_provider.dart';
import '../../../provider/usermodel_provider.dart';
import '../../../services/socket_service.dart';
import '../message_screen/chat_screen.dart';

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
  final socketService = SocketService();
  List<Contact> contacts = [];
  List<dynamic> newMessageCounts = [];
  MachineM? machine;
  User? user;
  bool fetched = false;
  // List<MachineM> machinery = [];
// var responseJson = json.decode(response);
//     machine = Machine.fromJson(responseJson);
  @override
  void initState() {
    super.initState();
    socketService.initSocket(widget.contractlist.userId);
    socketService.socket.on('contact', (data) {
      try {
        print('contactsocket');
        List<dynamic> decodedData = json.decode(data);

        // Create a list of Contact objects from the JSON data
        List<Contact> newContacts =
            decodedData.map((jsonData) => Contact.fromJson(jsonData)).toList();

        // Add only the new contacts to the list of existing contacts
        for (final newContact in newContacts) {
          if (!contacts.any((contact) => contact.userid == newContact.userid)) {
            setState(() {
              contacts.add(newContact);
            });
          }
        }
      } catch (e) {
        print('Error decoding JSON: $e');
      }
    });
    socketService.socket.on('new_message_count', (data) {
      try {
        print('socket');
        setState(() {
          final contactId = data['contactId'];
          // final count = data['newMessageCount'];
          print('count');
          // Find the index of the contact in the contacts list
          // final contactIndex =
          //     contacts.indexWhere((contact) => contact.userid == contactId);

          var contactToUpdate = newMessageCounts.firstWhere(
              (contact) => contact["contactId"] == contactId,
              orElse: () => null);

          if (contactToUpdate != null) {
            contactToUpdate["newMessageCount"]++;
          }
// Increment the new message count for this contact by 1
          // if (contactIndex >= 0) {
          //   setState(() {
          //     newMessageCounts[contactIndex]['newMessageCount'] += count;
          //   });
          // }
        });
      } catch (e) {
        print('Error updating new message count: $e');
      }
    });
    fachemachine(widget.contractlist.machineId);
    // facheuser(widget.contractlist.ownerId);
  }

  // void facheuser(String useID) async {
  //   // try {
  //   var response = await networkHandler.get("/api/user/${useID}");
  //   print(response);
  //   Map<String, dynamic> userData = json.decode(response.body);
  //   print(userData);

  //   setState(() {
  //     user = User.fromJson(userData);
  //     fetched = true;
  //   });
  // }

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
  void dispose() {
    socketService.socket.off('new_message_count');
    socketService.socket.off('contact');
    socketService.closeConnection();
    super.dispose();
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
          IconButton(
            onPressed: () {
              Provider.of<DropDownProvider>(context, listen: false)
                          .selectedAccount ==
                      'Farmer'
                  ? Navigator.pushNamed(context, '/')
                  : null;
            },
            icon: Provider.of<DropDownProvider>(context, listen: false)
                        .selectedAccount ==
                    'Service Provider'
                ? Icon(Icons.info)
                : Icon(Icons.delete),
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
                                        onPressed: () async {
                                          Map<String, String> updateData = {
                                            "status": "accepted",
                                          };
                                          var updateResponse =
                                              await networkHandler.put(
                                                  "/api/contracts/${widget.contractlist.contractId}",
                                                  updateData);
                                          if (updateResponse.statusCode ==
                                                  200 ||
                                              updateResponse.statusCode ==
                                                  201) {
                                            print("contract status updated");
                                          }

                                          Navigator.pushNamed(
                                              context, '/contrat_page');
                                        },
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
                                        onPressed: () {
                                          UserMProvider userProvider =
                                              Provider.of<UserMProvider>(
                                                  context,
                                                  listen: false);
                                          // final userProvider = Provider.of<UserMProvider>(context);
                                          final userModel =
                                              userProvider.userModel;

                                          print(userModel!.useid);
                                          print(widget.contractlist.userId);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatPage(
                                                        sender: userModel.useid,
                                                        receiver: widget
                                                            .contractlist
                                                            .userId,
                                                        name: "You",
                                                        socketService:
                                                            socketService,
                                                      )));
                                        },
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
