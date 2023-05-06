import 'package:armada/configuration/theme_manager.dart';
import 'package:armada/models/viewModel/drawerModel.dart';
import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/drower_provider.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  // till line 16 route code
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => HomeScreen(),
    );
  }

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      appBar: customAppBar(context),
      body: Text("to be .."),
      // side drawer
      drawer: navigationDrawer(),
      // bottom navbar
      bottomNavigationBar: bottomAppbar(context),
    );
  }
}

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
            accountName: const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Text('Login'),
            ),
            accountEmail: const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Text('SignUp'),
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
            height: 500,
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
