import 'dart:convert';

import 'package:armada/networkhandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../models/user.dart';
import '../../../models/usermodel.dart';
import '../../widgets/widgets.dart';

class FarmerProfile extends StatefulWidget {
  static const String routeName = '/farmer_profile';

  const FarmerProfile({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const FarmerProfile(),
    );
  }

  @override
  _FarmerProfileState createState() => _FarmerProfileState();
}

class _FarmerProfileState extends State<FarmerProfile> {
  NetworkHandler networkHandler = NetworkHandler();
  final storage = new FlutterSecureStorage();

  // UserProfileModel userProfileModel =
  //     UserProfileModel(firstName: '', lastName: '', phone: null, role: '');
  User? user;
  bool fetched = false;

  UserModel usermode = UserModel(
      firstname: '',
      password: '',
      lastname: '',
      phone: '',
      useid: '',
      image: '');

  void initState() {
    super.initState();
    fetchData();
  }

  // final storage = new FlutterSecureStorage();

  void fetchData() async {
    String? userJson = await storage.read(key: 'userm');

    if (userJson != null) {
      // Convert JSON to UserModel
      setState(() {
        usermode = UserModel.fromJson(json.decode(userJson));
        fetched = true;
      });

      // Use the storedUser object as needed in your application
      print('Stored user: ${usermode.firstname} ${usermode.lastname}');
    } else {
      print("empity");
    }
  }

  @override
  Widget build(BuildContext context) {
    // const user = UserPreferences.myUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/edit_farmer_profile');
            },
            icon: const Icon(Icons.edit_sharp),
          ),
        ],
      ),
      body: fetched
          ? ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 20,
                ),
                // ProfileWidget(
                //   imagePath: user.imagePath,
                //   onClicked: () async {},
                // ),
                const SizedBox(height: 24),
                buildName(usermode),
                const SizedBox(height: 24),
                const SizedBox(height: 24),
                NumbersWidget(),
                const SizedBox(height: 48),
                buildAbout(usermode),
              ],
            )
          : CircularProgressIndicator.adaptive(),
    );
  }

  Widget buildName(UserModel user) => Column(
        children: [
          Text(
            user.firstname,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.phone.toString(),
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildAbout(UserModel user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.phone,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
