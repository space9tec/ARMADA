import 'package:armada/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../models/viewModel/drawerModel.dart';

class GustNavigationDrawer extends StatelessWidget {
  const GustNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
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
          Expanded(
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return gCustomListTile(
                    ind: index,
                    title: gustDrawerItem[index].title,
                    icon: gustDrawerItem[index].icon);
              },
              itemCount: gustDrawerItem.length,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return BgCustomListTile(
                  title: gustBDrawerItem[index].title,
                  icon: gustBDrawerItem[index].icon,
                  ind: index,
                );
              },
              itemCount: gustBDrawerItem.length,
            ),
          ),
        ],
      ),
    );
  }
}
