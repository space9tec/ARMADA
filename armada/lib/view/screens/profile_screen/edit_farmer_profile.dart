import 'package:armada/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../widgets/widgets.dart';
import 'package:armada/models/user.dart';

class EditFarmerProfile extends StatefulWidget {
  static const String routeName = '/edit_farmer_profile';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => EditFarmerProfile(),
    );
  }

  @override
  _EditFarmerProfileState createState() => _EditFarmerProfileState();
}

class _EditFarmerProfileState extends State<EditFarmerProfile> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.done),
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 20,
          ),
          ProfileEdit(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(
            height: 35,
          ),
          const Padding(
            padding: EdgeInsets.all(28.0),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "First Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Farmer name",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 28.0, right: 28.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 3),
                labelText: "Last Name",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "Last name",
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 28.0, right: 28.0),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Phone no.",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "0909906745",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 28.0, right: 28.0),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Location",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Location",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About who',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
