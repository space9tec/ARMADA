import 'package:flutter/material.dart';

Widget bottomAppbar(BuildContext context) {
  return BottomAppBar(
      color: Theme.of(context).bottomAppBarTheme.color,
      child: Container(
        height: 70,
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
                  Navigator.pushNamed(context, '/login');
                }),
            IconButton(
                icon: const Icon(
                  Icons.shop,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/main_service');
                }),
          ],
        ),
      ));
}
