import 'dart:convert';

import 'package:armada/networkhandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../models/user.dart';
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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    String? userid = await storage.read(key: "userid");

    var response = await networkHandler.get("/api/user/${userid}");
    print(response.body.toString());
    Map<String, dynamic> userData = json.decode(response.body);

    setState(() {
      user = User.fromJson(userData);
      fetched = true;
    });
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
                buildName(user!),
                const SizedBox(height: 24),
                const SizedBox(height: 24),
                NumbersWidget(),
                const SizedBox(height: 48),
                buildAbout(user!),
              ],
            )
          : CircularProgressIndicator.adaptive(),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.phone.toString(),
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
