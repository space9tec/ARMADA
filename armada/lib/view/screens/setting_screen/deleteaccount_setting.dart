import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../models/usermodel.dart';
import '../../../networkhandler.dart';

class DeleteAccount extends StatefulWidget {
  static const String routeName = '/deleteAccount';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const DeleteAccount(),
    );
  }

  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  NetworkHandler networkHandler = NetworkHandler();
  final storage = const FlutterSecureStorage();

  // User? user;
  bool fetched = false;

  UserModel usermode = const UserModel(
      firstname: '',
      password: '',
      lastname: '',
      phone: '',
      useid: '',
      image: '');

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void _deleteAccount() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Delete User Account.'),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Theme.of(context).primaryColor),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Delete'),
              onPressed: () async {
                Map<String, String> data = {
                  "phone": usermode.phone,
                };
                var response =
                    await networkHandler.postt("/api/auth/delete", data);
                if (response.statusCode == 200) {
                  await storage.delete(key: "token");

                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/guest', (Route<dynamic> route) => false);

                  BotToast.showText(
                    text: "User deleted",
                    duration: const Duration(seconds: 2),
                    contentColor: Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 16.0, color: Color(0xFF006837)),
                  );
                } else {
                  print("faild");
                  print(response.body.toString());
                }
              },
            ),
          ],
        );
      },
    );
  }

  void fetchData() async {
    String? userJson = await storage.read(key: 'userm');

    if (userJson != null) {
      // Convert JSON to UserModel
      setState(() {
        usermode = UserModel.fromJson(json.decode(userJson));
        fetched = true;
      });
      print('Stored user: ${usermode.firstname} ${usermode.lastname}');
    } else {
      print("empity");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Why you want to delete your account:',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            TextField(),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _deleteAccount,
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }
}
