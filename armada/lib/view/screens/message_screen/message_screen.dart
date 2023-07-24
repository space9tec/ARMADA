import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../models/model.dart';
import '../../../networkhandler.dart';
import '../../../services/socket_service.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key, required this.userl}) : super(key: key);

  final UserModel userl;

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  // String UserId=;

  NetworkHandler networkHandler = NetworkHandler();
  final socketService = SocketService();
  // late IO.Socket? socket;

  List<UserModel> contacts = [];
  List<dynamic> newMessageCounts = [];

  bool _dataFetched = false;

  Future<void> fetchData() async {
    if (_dataFetched) {
      return; // data has already been fetched, no need to call the API again
    }
    try {
      var response = await networkHandler
          .get("/api/message/fetch-users/${widget.userl.useid}");

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data != null &&
            data['contacts'] != null &&
            data['newMessageCounts'] != null) {
          setState(() {
            // print(data['contacts']);
            print("se");
            print(widget.userl.useid);

            contacts = List.from(data['contacts'])
                .map((contactJson) =>
                    UserModel.fromJson(json.decode(json.encode(contactJson))))
                .toList();
            newMessageCounts = List.from(data['newMessageCounts'])
                .map((countJson) => json.decode(json.encode(countJson)))
                .toList();
          });
        } else {
          print("No users found.");
        }

        _dataFetched = true;
      } else {
        print("API calll failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetchingn users: $e");
    }
  }

  @override
  void initState() {
    // socket =
    //     IO.io('https://armada-server.glitch.me?userId=${widget.userl.useid}');

    // socket = IO.io('https://armada-server.glitch.me', <String, dynamic>{
    //   'transports': ['websocket'],
    //   'autoConnect': false,
    //   'query': {'userId': widget.userl.useid},
    // });

    // print(socket!.query);
    socketService.initSocket(widget.userl.useid);
    // print(socket!.query);

    // socket!.connect();
    print("socket");
    print(widget.userl.useid);

    // Listen for the 'contact' event and add the new contact to the contact list
    try {
      socketService.socket!.on('contact', (data) {
        try {
          print('contactsocket');
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
    } catch (e) {
      print("not working $e");
    }
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
    super.initState();
  }

  @override
  void dispose() {
    // socket?.off('new_message_count');
    // socket?.off('contact');
    // socket!.destroy();

    socketService.socket?.disconnect();
    socketService.socket?.dispose();
    socketService.closeConnection();

    // socket!.clearListeners(); // Clear all event listeners
    // socket = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        // leading: InkWell(onTap: resetSocket, child: Icon(Icons.ac_unit)),
      ),
      body: FutureBuilder<void>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (BuildContext context, int index) {
              final contact = contacts[index];
              final count = newMessageCounts[index]['newMessageCount'];
              return ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.black26,
                    backgroundImage: NetworkImage(
                        "https://armada-server.glitch.me/api/auth/Image/${contact.image}")),
                title: Text(contact.firstname),
                trailing:
                    count > 0 && contacts.length == newMessageCounts.length
                        ? CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 12,
                            child: Text(
                              '${newMessageCounts[index]['newMessageCount']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : null,
                onTap: () => _navigateToChatPage(context, contact, index),
              );
            },
          );
        },
      ),
      drawer: navigationDrawer(),
      bottomNavigationBar: bottomAppbar(context),
    );
  }

  void _navigateToChatPage(BuildContext context, UserModel contact, int index) {
    setState(() {
      newMessageCounts[index]['newMessageCount'] = 0;
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          sender: widget.userl.useid,
          receiver: contact.useid,
          name: contact.firstname,
          socketService: socketService,
        ),
      ),
    );
  }
}
