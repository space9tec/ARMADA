import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../networkhandler.dart';
import '../../../services/socket_service.dart';
import '../../widgets/widgets.dart';
import '../../../models/model.dart';
import '../screens.dart';

class DisplayNotification extends StatefulWidget {
  static const String routeName = '/display_notification';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => DisplayNotification(),
    );
  }

  DisplayNotification({super.key});

  @override
  State<DisplayNotification> createState() => _DisplayNotificationState();
}

class _DisplayNotificationState extends State<DisplayNotification> {
  NetworkHandler networkHandler = NetworkHandler();

  // List newItem = ["liked", "follow"];
  // List todayItem = ["follow", "liked", "liked"];

  // Notification 1
// User ID: "12345"
// Message: "You have a new message from John Doe."
// Created At: "2023-08-08 10:30:00"
// Updated At: "2023-08-08 10:35:00"
// Owner ID: null
// Contract ID: null
// Notification 2
// User ID: "98765"
// Message: "Your contract with ABC Company has been approved."
// Created At: "2023-08-08 15:45:00"
// Updated At: "2023-08-08 15:50:00"
// Owner ID: "54321"
// Contract ID: "C123456"

  // Notifications notifications = Notifications(
  //     created_at: DateTime.parse('2023-08-08 15:45:00'),
  //     message: 'Your contract with ABC Company has been approved',
  //     updated_at: DateTime.parse('2023-08-08 15:45:00'),
  //     user_id: 'C123456');

  // Notifications notifications1 = Notifications(
  //     created_at: DateTime.parse('2023-08-08 15:45:00'),
  //     message: 'You have a new message from John Doe.',
  //     updated_at: DateTime.parse('2023-08-08 15:45:00'),
  //     user_id: 'C123457');

  // List<Notifications> notification = [];

  List<Notifications> notifications = [
    // Notifications(
    //   user_id: "12345",
    //   message: "You have a new message from John Doe.",
    //   created_at: DateTime.parse("2023-08-08 10:30:00"),
    //   // updated_at: DateTime.parse("2023-08-08 10:35:00"),
    // ),
    // Notifications(
    //   user_id: "98765",
    //   message: "Your contract with ABC Company has been approved.",
    //   created_at: DateTime.parse("2023-08-08 15:45:00"),
    //   // updated_at: DateTime.parse("2023-08-08 15:50:00"),
    //   owner_id: "54321",
    //   contract_id: "C123456",
    // ),
  ];
  final socketService = SocketService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNotification();
  }

  // @override
  // void dispose() {
  //   // socket?.off('new_message_count');
  //   // socket?.off('contact');
  //   // socket!.destroy();

  //   socketService.closeConnection();

  //   // socket!.clearListeners(); // Clear all event listeners
  //   // socket = null;
  //   super.dispose();
  // }

  // String? name;
  void fetchNotification() async {
    try {
      var response =
          await networkHandler.get("/api/notifications/fetch-notification");
      print("Hello still fetching");
      print(response.body);
      // setState(() {
      //   name = response.body["name"];
      // });
      setState(() {
        notifications = (json.decode(response.body) as List)
            .map((data) => Notifications.fromJson(data))
            .toList();
      });
    } catch (e) {
      print("Failed to fethc Notification ${e}");
      return;
    }
  }

  ContractsModel? contract;
  MachineM singlemachine = MachineM(
      machineId: "",
      ownerId: "",
      manufacturer: "",
      model: "",
      type: "",
      status: "",
      region: "",
      attachmenttype: "",
      year: null,
      hourmeter: null,
      horsepower: null,
      graintank: null,
      graintypes: null,
      workingcapacity: null,
      requiredpower: null,
      additionalinformation: null,
      imageFile: null);

  // void fetchContractInfo(String? id) async {
  //   var responsecontract = await networkHandler.get("/api/contracts/${id}");

  //   setState(() {
  //     contract = ContractsModel.fromJson(json.decode(responsecontract.body));
  //   });

  //   var responsemachine =
  //       await networkHandler.get("/api/machinery/${contract?.machineId}");

  //   setState(() {
  //     singlemachine = MachineM.fromJson(json.decode(responsemachine.body));
  //   });
  //   // return singlemachine;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Notification"),
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return InkWell(
                onTap: () {
                  print(notification.type);
                  switch (notification.type) {
                    case "none":
                      break;
                    case "Message":
                      socketService.initSocket(notification.user_id);
                      // initState();

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            sender: notification.user_id,
                            receiver: notification.owner_id,
                            // name: contact.firstname,
                            socketService: socketService,
                          ),
                        ),
                      );
                      break;
                    case "Contract":
                      print("object");
                      if (notification.contract_id != null) {
                        // fetchContractInfo(notification.contract_id);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ItemPage(
                                  machineid: notification.contract_id)),
                        );
                      }

                      break;
                  }
                },
                child: ListTile(
                  title: Text(notification.message),
                  subtitle: Text(notification.created_at.toString()),
                  trailing: Icon(Icons.notifications),
                  onTap: () {
                    // Handle notification tap
                    print(notification.type);
                    switch (notification.type) {
                      case "none":
                        break;
                      case "Message":
                        //                  Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => ChatPage(
                        //       sender: widget.userl.useid,
                        //       receiver: contact.useid,
                        //       name: contact.firstname,
                        //       socketService: socketService,
                        //     ),
                        //   ),
                        // );
                        break;
                      case "Contract":
                        print("object");
                        if (notification.contract_id != null) {
                          // fetchContractInfo(notification.contract_id);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ItemPage(
                                    machineid: notification.contract_id)),
                          );
                        }

                        break;
                    }
                  },
                ),
              );
            })

        //  Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        // //   children: [
        //     // Text(
        //     //   "New",
        //     //   style: Theme.of(context).textTheme.bodyMedium,
        //     // ),
        //     // const SizedBox(
        //     //   height: 10,
        //     // ),
        //     // ListView.builder(
        //     //   physics: const NeverScrollableScrollPhysics(),
        //     //   shrinkWrap: true,
        //     //   itemCount: newItem.length,
        //     //   itemBuilder: (context, index) {
        //     //     return newItem[index] == "follow"
        //     //         ? const CustomFollowNotifcation()
        //     //         : const CustomLikedNotifcation();
        //     //   },
        //     // ),
        //     // Padding(
        //     //   padding: const EdgeInsets.symmetric(vertical: 10),
        //     //   child: Text(
        //     //     "Today",
        //     //     style: Theme.of(context).textTheme.displayMedium,
        //     //   ),
        //     // ),
        //     // ListView.builder(
        //     //   physics: const NeverScrollableScrollPhysics(),
        //     //   shrinkWrap: true,
        //     //   itemCount: todayItem.length,
        //     //   itemBuilder: (context, index) {
        //     //     return todayItem[index] == "follow"
        //     //         ? const CustomFollowNotifcation()
        //     //         : const CustomLikedNotifcation();
        //     //   },
        //     // ),
        //     // Padding(
        //     //   padding: const EdgeInsets.symmetric(vertical: 10),
        //     //   child: Text(
        //     //     "Oldest",
        //     //     style: Theme.of(context).textTheme.bodyMedium,
        //     //   ),
        //     // // ),
        //     // ListView.builder(
        //     //   physics: const NeverScrollableScrollPhysics(),
        //     //   shrinkWrap: true,
        //     //   itemCount: oldesItem.length,
        //     //   itemBuilder: (context, index) {
        //     //     return oldesItem[index] == "follow"
        //     //         ? const CustomFollowNotifcation()
        //     //         : const CustomLikedNotifcation();
        //     //   },
        //     // ),
        //   ],
        // ),
        //       ),
        // ),
        // bottomNavigationBar: bottomAppbar(context),
        );
  }
}
