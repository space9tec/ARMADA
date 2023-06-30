import 'package:armada/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../models/viewModel/drawerModel.dart';

class gustnavigationDrawer extends StatelessWidget {
  gustnavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            onDetailsPressed: () {},
            otherAccountsPictures: [],
            accountName: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text('Login'),
              ),
            ),
            accountEmail: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text('SignUp'),
              ),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("assets/images/avatar_profile.png"),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.43,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return gCustomListTile(
                    ind: index,
                    title: gustDrawerItem[index].title,
                    icon: gustDrawerItem[index].icon);
              },
              itemCount: gustDrawerItem.length,
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return BgCustomListTile(
                  title: gustBDrawerItem[index].title,
                  icon: gustBDrawerItem[index].icon,
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
