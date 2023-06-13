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
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _location = TextEditingController();
  // final TextEditingController _about = TextEditingController();

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
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: TextField(
              controller: _firstName,
              decoration: const InputDecoration(
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
          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0),
            child: TextField(
              controller: _lastName,
              decoration: const InputDecoration(
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
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0),
            child: TextField(
              controller: _phone,
              decoration: const InputDecoration(
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
          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0),
            child: TextField(
              controller: _location,
              decoration: const InputDecoration(
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
          const SizedBox(
            height: 25,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 28.0, right: 28.0),
          //   child: TextFormField(
          //     controller: _about,
          //     maxLength: 200,
          //     maxLines: 4,
          //     keyboardType: TextInputType.multiline,
          //     decoration: InputDecoration(
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(15),
          //           borderSide: const BorderSide(
          //             width: 1,
          //             color: Colors.green,
          //           )),
          //       focusedBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(15),
          //           borderSide: const BorderSide(
          //             width: 1,
          //             color: Colors.green,
          //           )),
          //       prefixIcon: Icon(
          //         Icons.person,
          //         color: Theme.of(context).primaryColor,
          //       ),
          //       labelText: "About",
          //       helperText: "Write about you.",
          //     ),
          //   ),
          // )
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
