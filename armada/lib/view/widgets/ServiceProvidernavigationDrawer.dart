import 'package:armada/view/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../models/viewModel/drawerModel.dart';

class ServiceProvidernavigationDrawer extends StatelessWidget {
  const ServiceProvidernavigationDrawer({super.key});

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
                child: Text('Loginn'),
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
            // height: 370,
            height: MediaQuery.of(context).size.height * 0.43,

            child: ListView.builder(
              itemBuilder: (context, index) {
                return CustomServiceProviderListTile(
                  ind: index,
                  title: ServiceProviderDrawerItem[index].title,
                  isSelected: index,
                  icon: ServiceProviderDrawerItem[index].icon,
                );
              },
              itemCount: ServiceProviderDrawerItem.length,
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Container(
            // height: 300,
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
