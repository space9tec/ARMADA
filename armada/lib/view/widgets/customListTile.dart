import 'package:armada/provider/drower_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:armada/networkhandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final int isSelected;
  final int ind;

  CustomListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.ind,
    required this.isSelected,
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  NetworkHandler networkHandler = NetworkHandler();

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawerNotifire>(
      builder: (context, value, child) => InkWell(
        onTap: () {
          switch (widget.ind) {
            case 0:
              value.setCurrentDrawer(0);
              Navigator.pushNamed(context, '/farmer_profile');
              break;
            case 1:
              value.setCurrentDrawer(1);
              Navigator.pushNamed(context, '/farm_screen');
              break;
            case 2:
              value.setCurrentDrawer(2);
              Navigator.pushNamed(context, '/login');
              break;
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12, top: 0),
          child: Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      style: BorderStyle.solid,
                      width: 1,
                      color: Theme.of(context).primaryColor)),
              color: (value.getCurrentDrawer == widget.isSelected)
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(widget.icon,
                    color: value.getCurrentDrawer == widget.isSelected
                        ? Colors.white
                        : Theme.of(context).primaryColor),
                SizedBox(width: 5),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: (value.getCurrentDrawer == widget.isSelected)
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BCustomListTile extends StatefulWidget {
  final String title;
  final IconData icon;

  final int ind;

  BCustomListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.ind,
  });

  @override
  State<BCustomListTile> createState() => _BCustomListTileState();
}

class _BCustomListTileState extends State<BCustomListTile> {
  NetworkHandler networkHandler = NetworkHandler();

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawerNotifire>(
      builder: (context, value, child) => InkWell(
        onTap: () {
          switch (widget.ind) {
            case 0:
              value.setCurrentDrawer(3);
              Navigator.pushNamed(context, '/Profilee');
              break;
            case 1:
              value.setCurrentDrawer(4);
              Navigator.pushNamed(context, '/Farme');
              break;
            case 2:
              value.setCurrentDrawer(5);
              logout();
              break;
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12, top: 0),
          child: Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      style: BorderStyle.solid,
                      width: 1,
                      color: Theme.of(context).primaryColor)),
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(widget.icon, color: Theme.of(context).primaryColor),
                SizedBox(width: 5),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  logout() async {
    final storage = new FlutterSecureStorage();

    var response = await networkHandler.get("/api/auth/logout");
    String? token = await storage.read(key: "token");
    if (token != null) {
      if (response.statusCode == 200) {
        await storage.delete(key: "token");
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/guest', (Route<dynamic> route) => false);
        print("Logedout");
      } else {
        print("failed");
      }
    } else {
      print("Already logged out");
    }
  }
}
