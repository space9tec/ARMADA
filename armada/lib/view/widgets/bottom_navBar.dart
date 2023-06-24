import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';
import '../../provider/usermodel_provider.dart';
import '../screens/message_screen/message_screen.dart';

Widget bottomAppbar(BuildContext context) {
  return BottomAppBar(
    color: Theme.of(context).bottomAppBarTheme.color,
    child: Container(
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
                Icons.message,
                color: Colors.white,
              ),
              onPressed: () {
                // Navigator.pushNamed(context, '/login');
                UserMProvider userProvider =
                    Provider.of<UserMProvider>(context, listen: false);
                // final userProvider = Provider.of<UserMProvider>(context);
                final userModel = userProvider.userModel;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserListPage(userl: userModel!)),
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
        ],
      ),
    ),
  );
}

Widget gustbottomAppbar(BuildContext context) {
  return BottomAppBar(
    color: Theme.of(context).bottomAppBarTheme.color,
    child: Container(
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
              Navigator.pushNamed(context, '/guest');
            },
          ),
          IconButton(
              icon: const Icon(
                Icons.account_box,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              }),
        ],
      ),
    ),
  );
}
