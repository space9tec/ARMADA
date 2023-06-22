import 'package:armada/networkhandler.dart';
import 'package:armada/utils/user_preferences.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model/userProfile_model.dart';
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
  UserProfileModel userProfileModel =
      UserProfileModel(firstName: '', lastName: '', phone: null, role: '');

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    // var response = await networkHandler.get("/api/farm/");
    // print(response.body.toString());
    setState(() {
      // userProfileModel = UserProfileModel.fromJson(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.myUser;

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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 20,
          ),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(userProfileModel),
          const SizedBox(height: 24),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout(userProfileModel),
        ],
      ),
    );
  }

  Widget buildName(UserProfileModel user) => Column(
        children: [
          Text(
            user.firstName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.phone.toString(),
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildAbout(UserProfileModel user) => Container(
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
              user.role,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
