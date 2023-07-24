import 'package:armada/provider/drower_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:armada/networkhandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bot_toast/bot_toast.dart';

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
              Navigator.pushNamed(context, '/aboutscreen');
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
                      color: Colors.black12)),
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(widget.icon, color: Colors.grey),
                SizedBox(width: 15),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 17,
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
              Navigator.pushNamed(context, '/service_provider_setting');
              break;
            case 1:
              value.setCurrentDrawer(4);
              Navigator.pushNamed(context, '/help');
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
                      color: Colors.black12)),
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(widget.icon, color: Colors.grey),
                SizedBox(width: 15),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 17,
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
        BotToast.showText(
          text: "Logged out",
          duration: Duration(seconds: 2),
          contentColor: Colors.white,
          textStyle: TextStyle(fontSize: 16.0, color: Color(0xFF006837)),
        );
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

class gCustomListTile extends StatefulWidget {
  final String title;
  final IconData icon;

  final int ind;

  gCustomListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.ind,
  });

  @override
  State<gCustomListTile> createState() => _gCustomListTileState();
}

class _gCustomListTileState extends State<gCustomListTile> {
  NetworkHandler networkHandler = NetworkHandler();

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawerNotifire>(
      builder: (context, value, child) => InkWell(
        onTap: () {
          switch (widget.ind) {
            case 0:
              value.setCurrentDrawer(1);
              Navigator.pushNamed(context, '/guest');
              break;
            case 1:
              value.setCurrentDrawer(2);
              Navigator.pushNamed(context, '/login');
              break;
            case 2:
              value.setCurrentDrawer(3);
              Navigator.pushNamed(context, '/aboutscreen');
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
                      color: Colors.black12)),
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(widget.icon, color: Colors.grey),
                SizedBox(width: 15),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 17,
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

class BgCustomListTile extends StatefulWidget {
  final String title;
  final IconData icon;

  final int ind;

  BgCustomListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.ind,
  });

  @override
  State<BgCustomListTile> createState() => _BgCustomListTileState();
}

class _BgCustomListTileState extends State<BgCustomListTile> {
  NetworkHandler networkHandler = NetworkHandler();

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawerNotifire>(
      builder: (context, value, child) => InkWell(
        onTap: () {
          switch (widget.ind) {
            case 0:
              value.setCurrentDrawer(4);
              Navigator.pushNamed(context, '/service_provider_setting');
              break;
            case 1:
              value.setCurrentDrawer(5);
              Navigator.pushNamed(context, '/help');
              break;
            case 2:
              value.setCurrentDrawer(6);
              Navigator.pushNamed(context, '/contactus');
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
                      color: Colors.black12)),
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(widget.icon, color: Colors.grey),
                SizedBox(width: 15),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 17,
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
