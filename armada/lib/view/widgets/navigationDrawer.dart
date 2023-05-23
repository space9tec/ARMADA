import 'package:armada/view/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../models/viewModel/drawerModel.dart';

class navigationDrawer extends StatelessWidget {
  const navigationDrawer({super.key});

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
          // bulidHeader(context),
          // buildMenuItems(context),
          Container(
            height: 370,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return CustomListTile(
                  // onTap: () {
                  //   return(
                  //   switch (index) {
                  //     case 0:
                  //       value.setCurrentDrawer(0);
                  //       Navigator.pushNamed(context, '/login');

                  //       break;
                  //     case 1:
                  //       value.setCurrentDrawer(1);
                  //       Navigator.pushNamed(context, '/register');
                  //       break;
                  //     case 2:
                  //       value.setCurrentDrawer(2);
                  //       Navigator.pushNamed(context, '/login');
                  //       break;
                  //   }
                  //   );
                  // },
                  ind: index,
                  title: DrawerItem[index].title,
                  isSelected: index,
                  icon: DrawerItem[index].icon,
                );
              },
              itemCount: DrawerItem.length,
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Container(
            height: 300,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return BCustomListTile(
                  // onTap: () {
                  //   return(
                  //   switch (index) {
                  //     case 0:
                  //       value.setCurrentDrawer(0);
                  //       Navigator.pushNamed(context, '/login');

                  //       break;
                  //     case 1:
                  //       value.setCurrentDrawer(1);
                  //       Navigator.pushNamed(context, '/register');
                  //       break;
                  //     case 2:
                  //       value.setCurrentDrawer(2);
                  //       Navigator.pushNamed(context, '/login');
                  //       break;
                  //   }
                  //   );
                  // },

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

//   Widget bulidHeader(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       color: Theme.of(context).primaryColor,
//       padding: EdgeInsets.only(
//         top: 24 + MediaQuery.of(context).padding.top,
//         bottom: 24,
//       ),
//       child: Column(
//         children: [
//           const CircleAvatar(
//             radius: 52,
//           ),
//           addVerticalSpace(12),
//           TextButton(
//             onPressed: () {
//               Navigator.pushNamed(context, '/login');
//             },
//             child: const Text(
//               'Login',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18.0,
//               ), //title
//               //aligment
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildMenuItems(BuildContext context) {
//     return Column();
//   }
}
