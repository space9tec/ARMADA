import 'package:flutter/material.dart';
import '../../models/usermodel.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../screens/message_screen/message_screen.dart';

Widget bottomAppbar(BuildContext context) {
  return BottomAppBar(
    color: Theme.of(context).bottomAppBarTheme.color,
    child: SizedBox(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          IconButton(
              icon: const Icon(
                Icons.align_vertical_bottom,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/owneritem');
              }),
          IconButton(
              icon: const Icon(
                Icons.message,
                color: Colors.white,
              ),
              onPressed: () async {
                final storage = const FlutterSecureStorage();

                String? userJson = await storage.read(key: 'userm');
                print("hell");
                print(userJson);
                // Convert JSON to UserModel
                //             UserModel usermode = const UserModel(
                // firstname: '',
                // password: '',
                // lastname: '',
                // phone: '',
                // useid: '',
                // image: '');

                UserModel usermode = UserModel.fromJson(json.decode(userJson!));

                // Use the storedUser object as needed in your application

                // UserMProvider userProvider =
                //     Provider.of<UserMProvider>(context, listen: false);

                // final userModel = userProvider.userModel;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserListPage(userl: usermode)),
                );
              }),
          IconButton(
              icon: const Icon(
                Icons.shop,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/contrat_page');
              }),
          IconButton(
              icon: const Icon(
                Icons.account_box_sharp,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/farmer_profile');
              }),
        ],
      ),
    ),
  );
}

Widget gustbottomAppbar(BuildContext context) {
  return BottomAppBar(
    color: Theme.of(context).bottomAppBarTheme.color,
    child: SizedBox(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/guest');
                },
              ),
              const Text('Home', style: TextStyle(color: Colors.white)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  icon: const Icon(
                    Icons.account_box,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  }),
              const Text('Login', style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    ),
  );
}
