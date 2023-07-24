import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bot_toast/bot_toast.dart';

import '../../../models/model.dart';
import '../../../networkhandler.dart';
import '../../../services/socket_service.dart';
import '../../../utils/helper_widget.dart';
import '../screens.dart';

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
  List<UserModel> contacts = [];
  List<dynamic> newMessageCounts = [];
  MachineM? machine;
  UserModel? user;
  bool fetched = false;

  @override
  void initState() {
    super.initState();
    socketService.initSocket(widget.contractlist.userId);
    socketService.socket!.on('contact', (data) {
      try {
        List<dynamic> decodedData = json.decode(data);

        // Create a list of Contact objects from the JSON data
        List<UserModel> newContacts = decodedData
            .map((jsonData) => UserModel.fromJson(jsonData))
            .toList();

        // Add only the new contacts to the list of existing contacts
        for (final newContact in newContacts) {
          if (!contacts.any((contact) => contact.useid == newContact.useid)) {
            setState(() {
              contacts.add(newContact);
            });
          }
        }
      } catch (e) {
        print('Error decoding JSON: $e');
      }
    });
    socketService.socket!.on('new_message_count', (data) {
      try {
        setState(() {
          final contactId = data['contactId'];

          var contactToUpdate = newMessageCounts.firstWhere(
              (contact) => contact["contactId"] == contactId,
              orElse: () => null);

          if (contactToUpdate != null) {
            contactToUpdate["newMessageCount"]++;
          }
        });
      } catch (e) {
        print('Error updating new message count: $e');
      }
    });
    fachemachine(widget.contractlist.machineId);
  }

  UserModel usermode = const UserModel(
      firstname: '',
      password: '',
      lastname: '',
      phone: '',
      useid: '',
      image: '');

  void fachemachine(String machinid) async {
    var response = await networkHandler.get("/api/machinery/$machinid");

    Map<String, dynamic> machineData = json.decode(response.body);

    setState(() {
      if (mounted) {
        machine = MachineM.fromJson(machineData["machinery"]);
        fetched = true;
      }
    });

    const storage = FlutterSecureStorage();
    String? userJson = await storage.read(key: 'userm');

    // List<dynamic> responseData = json.decode(response.body);
    setState(() {
      usermode = UserModel.fromJson(json.decode(userJson!));
    });
  }

  @override
  void dispose() {
    socketService.socket!.off('new_message_count');
    socketService.socket!.off('contact');
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
              widget.contractlist.ownerId != usermode.useid
                  ? Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return EditContract(
                            contractsModel: widget.contractlist);
                      },
                    ))
                  : null;
            },
            icon: fetched
                ? widget.contractlist.ownerId == usermode.useid
                    ? const Icon(Icons.share)
                    : const Icon(Icons.edit)
                : Icon(
                    Icons.donut_large_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
          ),
          IconButton(
            onPressed: () {
              widget.contractlist.ownerId != usermode.useid
                  ? showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          // backgroundColor: Colors.white,
                          title: const Text('Confirm Delete'),
                          content: const Text(
                              'Are you sure you want to delete this Farm?'),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                      Theme.of(context).primaryColor),
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: const Text('Delete'),
                              onPressed: () async {
                                var response = await networkHandler.delete(
                                    "/api/contracts/${widget.contractlist.contractId}");

                                if (response.statusCode == 200) {
                                  Navigator.pushNamed(context, '/contrat_page');

                                  BotToast.showText(
                                    text: "Contract Deleted",
                                    duration: const Duration(seconds: 2),
                                    contentColor: Colors.white,
                                    textStyle: const TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xFF006837)),
                                  );
                                } else {
                                  print("Faild" + response.body.toString());
                                }
                              },
                            ),
                          ],
                        );
                      },
                    )
                  : null;
            },
            icon: fetched
                ? widget.contractlist.ownerId == usermode.useid
                    ? const Icon(Icons.info)
                    : const Icon(Icons.delete)
                : Icon(
                    Icons.replay_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
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
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/tracter1.png'),
                      ),
                      addHorizontalSpace(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addVerticalSpace(8),
                            Text(
                              'Owner: ${machine?.manufacturer}',
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
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Image.network(
                                "https://armada-server.glitch.me/api/machinery/image/${machine!.imageFile}",
                                height:
                                    MediaQuery.of(context).size.height * 0.25),
                          ),
                        ),
                        addVerticalSpace(40),
                        Text(
                          'Contract Start Date: ${widget.contractlist.rent_start_time}',
                        ),
                        addVerticalSpace(4),
                        Text(
                          'Contract End Date: ${widget.contractlist.rent_end_time}',
                        ),
                        widget.contractlist.ownerId == usermode.useid
                            ? Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          Map<String, String> updateData = {
                                            "status": "rejected",
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
                                            const Color(0xFF006837),
                                          ),
                                        ),
                                        child: const Text(
                                          'Reject',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
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
                                            const Color(0xFF006837),
                                          ),
                                        ),
                                        child: const Text(
                                          'Confirm',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Start Message
                                          // Navigator.of(context).push(
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             ChatPage(
                                          //               sender: usermode.useid,
                                          //               receiver: widget
                                          //                   .contractlist
                                          //                   .userId,
                                          //               name:
                                          //                   usermode.firstname,
                                          //               socketService:
                                          //                   socketService,
                                          //             )));
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            const Color(0xFF006837),
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
          : const Center(
              child: CircularProgressIndicator(color: Color(0xFF006837))),
    );
  }
}
