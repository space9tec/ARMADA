import 'package:armada/provider/drower_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomServiceProviderListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final int isSelected;
  final int ind;

  CustomServiceProviderListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.ind,
    required this.isSelected,
  });

  @override
  State<CustomServiceProviderListTile> createState() =>
      _CustomServiceProviderListTileState();
}

class _CustomServiceProviderListTileState
    extends State<CustomServiceProviderListTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DrawerNotifire>(
      builder: (context, value, child) => InkWell(
        onTap: () {
          switch (widget.ind) {
            case 0:
              value.setCurrentDrawer(0);
              Navigator.pushNamed(context, '/serviceProvider_profile');
              break;
            case 1:
              value.setCurrentDrawer(1);
              Navigator.pushNamed(context, '/machie_screen');
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

class BCustomServiceProviderListTile extends StatefulWidget {
  final String title;
  final IconData icon;

  final int ind;

  BCustomServiceProviderListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.ind,
  });

  @override
  State<BCustomServiceProviderListTile> createState() =>
      _BCustomServiceProviderListTileState();
}

class _BCustomServiceProviderListTileState
    extends State<BCustomServiceProviderListTile> {
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
              Navigator.pushNamed(context, '/logine');
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
}
