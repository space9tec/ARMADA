import 'package:flutter/material.dart';
import 'package:armada/models/user.dart';

class Editfarm extends StatefulWidget {
  static const String routeName = '/edit_farm';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => Editfarm(),
    );
  }

  @override
  _EditfarmState createState() => _EditfarmState();
}

class _EditfarmState extends State<Editfarm> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  // final TextEditingController _phone = TextEditingController();
  final TextEditingController _location = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // const user = UserPreferences.myUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 20,
          ),
          // ProfileEdit(
          //   imagePath: user.imagePath,
          //   onClicked: () async {},
          // ),
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: TextField(
              controller: _firstName,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Farm Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Farm name",
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
                labelText: "Farm size",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "Farm size",
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
              controller: _location,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Crop Type",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Crop Type",
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
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.firstname,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.phone,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildAbout(User user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About who',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Text(
            //   user.about,
            //   style: const TextStyle(fontSize: 16, height: 1.4),
            // ),
          ],
        ),
      );
}
