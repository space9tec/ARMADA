import 'dart:async';
import 'dart:convert';

// import 'package:chararmada/model/user.dart';
// import 'package:chararmada/socket_service.dart';
// import 'model/contact.dart';
// import 'networkhandler.dart';
// import 'singlmessagepage.dart';
import 'package:armada/view/screens/message_screen/chat_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/conversation.dart';
import '../../../models/user.dart';
import '../../../networkhandler.dart';
import '../../../services/socket_service.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key, required this.userl}) : super(key: key);

  final User userl;

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  NetworkHandler networkHandler = NetworkHandler();

  final socketService = SocketService();
  List<Contact> contacts = [];
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
        print(data);
        if (data != null &&
            data['contacts'] != null &&
            data['newMessageCounts'] != null) {
          setState(() {
            print(data);
            contacts = List.from(data['contacts'])
                .map((contactJson) =>
                    Contact.fromJson(json.decode(json.encode(contactJson))))
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
        print("API call failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  @override
  void initState() {
    super.initState();

    socketService.initSocket(widget.userl.useid);

    // Initialize the SocketService instance when the widget is created
//     socketService.initSocket(widget.userl.userid);

    // Listen for the 'contact' event and add the new contact to the contact list
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
      ),
      body: FutureBuilder<void>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
                leading: CircleAvatar(backgroundColor: Colors.black26),
                title: Text(contact.username),
                trailing:
                    count > 0 && contacts.length == newMessageCounts.length
                        ? CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 12,
                            child: Text(
                              '${newMessageCounts[index]['newMessageCount']}',
                              style: TextStyle(
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
    );
  }

  void _navigateToChatPage(BuildContext context, Contact contact, int index) {
    setState(() {
      newMessageCounts[index]['newMessageCount'] = 0;
    });

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChatPage(
              sender: widget.userl.useid,
              receiver: contact.userid,
              name: contact.username,
              socketService: socketService,
            )));
  }
}
