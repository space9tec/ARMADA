import 'package:armada/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/viewModel/drawerModel.dart';
import '../../provider/user_provider.dart';

class navigationDrawer extends StatelessWidget {
  navigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            onDetailsPressed: () {},
            otherAccountsPictures: [],
            accountName: userProvider.name != null
                ? GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text("Id: ${userProvider.name}"),
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
            accountEmail: userProvider.name == null
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
            color: Colors.black,
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
