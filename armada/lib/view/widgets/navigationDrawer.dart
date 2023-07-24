import 'dart:convert';

import 'package:armada/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../models/usermodel.dart';
import '../../models/viewModel/drawerModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class navigationDrawer extends StatefulWidget {
  navigationDrawer({super.key});

  @override
  State<navigationDrawer> createState() => _navigationDrawerState();
}

class _navigationDrawerState extends State<navigationDrawer> {
  UserModel usermode = UserModel(
      firstname: '',
      password: '',
      lastname: '',
      phone: '',
      useid: '',
      image: '');

  void initState() {
    super.initState();
    fetchData();
  }

  final storage = new FlutterSecureStorage();

  void fetchData() async {
    String? userJson = await storage.read(key: 'userm');

    if (userJson != null) {
      // Convert JSON to UserModel
      setState(() {
        usermode = UserModel.fromJson(json.decode(userJson));
      });

      // Use the storedUser object as needed in your application
      print('Stored user: ${usermode.firstname} ${usermode.lastname}');
    } else {
      print("empity");
    }
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            onDetailsPressed: () {},
            otherAccountsPictures: [],
            accountName: usermode.firstname != ""
                ? GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text("${usermode.firstname} ${usermode.lastname}"),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text('Login'),
                    )),
            accountEmail: usermode.firstname == ""
                ? GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text('SignUp'),
                    ),
                  )
                : null,
            // https://armada-server.glitch.me/api/auth/Image/image-1686746917955.webp

            currentAccountPicture: usermode.image != ""
                ? CircleAvatar(
                    child: ClipOval(
                        child: Image(
                            image: NetworkImage(
                                "https://armada-server.glitch.me/api/auth/Image/${usermode.image}"))),
                  )
                : null,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.43,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return CustomListTile(
                    ind: index,
                    title: DrawerItem[index].title,
                    isSelected: index,
                    icon: DrawerItem[index].icon);
              },
              itemCount: DrawerItem.length,
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 156, 155, 155),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return BCustomListTile(
                  title: BDrawerItem[index].title,
                  icon: BDrawerItem[index].icon,
                  ind: index,
                );
              },
              itemCount: BDrawerItem.length,
            ),
          ),
        ],
      ),
    );
  }
}
