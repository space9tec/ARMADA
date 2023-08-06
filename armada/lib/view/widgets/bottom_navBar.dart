import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../models/model.dart';
import '../../provider/provider.dart';
import '../screens/screens.dart';

Widget bottomAppbar(BuildContext context) {
  final myProvider = Provider.of<BottomNavigation>(context);
  return BottomAppBar(
    color: Theme.of(context).bottomAppBarTheme.color,
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              myProvider.setBottomNavPosition(0);
              Navigator.pushNamed(context, '/');
            },
            child: Container(
              decoration: const BoxDecoration(border: Border()),
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myProvider.position == 0
                      ? Icon(Icons.home, color: Colors.white)
                      : Icon(Icons.home_outlined, color: Colors.white),
                  Text('Home',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              myProvider.setBottomNavPosition(1);

              Navigator.pushNamed(context, '/owneritem');
            },
            child: Container(
              decoration: const BoxDecoration(border: Border()),
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myProvider.position == 1
                      ? Icon(Icons.align_vertical_bottom, color: Colors.white)
                      : Icon(Icons.align_vertical_bottom_outlined,
                          color: Colors.white),
                  Text('Item',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              myProvider.setBottomNavPosition(2);

              const storage = FlutterSecureStorage();

              String? userJson = await storage.read(key: 'userm');

              UserModel usermode = UserModel.fromJson(json.decode(userJson!));

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserListPage(userl: usermode)),
              );
            },
            child: Container(
              decoration: const BoxDecoration(border: Border()),
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myProvider.position == 2
                      ? Icon(Icons.message, color: Colors.white)
                      : Icon(Icons.message_outlined, color: Colors.white),
                  Text('Message',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              myProvider.setBottomNavPosition(3);

              Navigator.pushNamed(context, '/contrat_page');
            },
            child: Container(
              decoration: const BoxDecoration(border: Border()),
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myProvider.position == 3
                      ? Icon(Icons.shop, color: Colors.white)
                      : Icon(Icons.shop_outlined, color: Colors.white),
                  Text('Contract',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              myProvider.setBottomNavPosition(4);

              Navigator.pushNamed(context, '/farmer_profile');
            },
            child: Container(
              decoration: const BoxDecoration(border: Border()),
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myProvider.position == 4
                      ? Icon(Icons.account_box, color: Colors.white)
                      : Icon(Icons.account_box_outlined, color: Colors.white),
                  Text('Profile',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget gustbottomAppbar(BuildContext context) {
  return BottomAppBar(
    color: Theme.of(context).bottomAppBarTheme.color,
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/guest');
            },
            child: Container(
              decoration: const BoxDecoration(border: Border()),
              width: MediaQuery.of(context).size.width * 0.5,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home, color: Colors.white),
                  Text('Home',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Container(
              decoration: const BoxDecoration(border: Border()),
              width: MediaQuery.of(context).size.width * 0.5,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_box, color: Colors.white),
                  Text('Login',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
