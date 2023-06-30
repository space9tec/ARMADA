import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/usermodel_provider.dart';
import '../screens/message_screen/message_screen.dart';

Widget ServiceProviderbottomAppbar(BuildContext context) {
  return BottomAppBar(
      color: Theme.of(context).bottomAppBarTheme.color,
      child: Container(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(
                Icons.analytics,
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
            IconButton(
                icon: const Icon(
                  Icons.contact_page,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Navigator.pushNamed(context, '/main_service');
                }),
          ],
        ),
      ));
}
