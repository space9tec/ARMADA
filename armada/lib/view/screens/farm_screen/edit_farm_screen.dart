import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:armada/models/user.dart';
import 'package:armada/models/farm.dart';
import 'package:armada/networkhandler.dart';
import 'package:bot_toast/bot_toast.dart';

import 'farmDetail_screen.dart';

class Editfarm extends StatefulWidget {
  static const String routeName = '/edit_farm';

  // static Route route() {
  //   return MaterialPageRoute(
  //     settings: const RouteSettings(name: routeName),
  //     builder: (context) => const Editfarm(
  //       farmlist: null,
  //       networkHandler: null,
  //     ),
  //   );
  // }

  const Editfarm(
      {super.key, required this.farmlist, required this.networkHandler});
  final FarmM farmlist;
  final NetworkHandler networkHandler;

  @override
  _EditfarmState createState() => _EditfarmState();
}

class _EditfarmState extends State<Editfarm> {
  // String value= widget.farmlist.farmname;
  final TextEditingController _farmName = TextEditingController();
  final TextEditingController _farmSize = TextEditingController();
  // final TextEditingController _phone = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _cropType = TextEditingController();
  final TextEditingController _soilType = TextEditingController();
  final TextEditingController _polygonlocation = TextEditingController();

  @override
  void initState() {
    super.initState();
    _farmName.text =
        widget.farmlist.farmname; // Set initial value for text field 1
    _farmSize.text = widget.farmlist.farmsize
        .toString(); // Set initial value for text field 2
    _location.text = widget.farmlist.longtude!;
    _cropType.text = widget.farmlist.croptype;
    _soilType.text = widget.farmlist.soiltype;
  }

  FarmM? farm;
  NetworkHandler? networkHandler = NetworkHandler();
  @override
  Widget build(BuildContext context) {
    // const user = UserPreferences.myUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () async {
              Map<String, String> data = {
                "_id": widget.farmlist.farmid,
                "farm_size": _farmSize.text,
                "farm_name": _farmName.text,
                "latitude": _location.text,
                "crops_grown": _cropType.text,
                "soil_type": _soilType.text,
                "longitude": _polygonlocation.text,
                // "owner_id": usermode.useid,
              };
              print(data);
              // var response = await networkHandler.postt(
              //     "/api/farm/delete", data);
              var response = await widget.networkHandler
                  .put("/api/farm/${widget.farmlist.farmid}", data);
              if (response.statusCode == 200) {
                Map<String, dynamic> output = json.decode(response.body);
                print("updated1");
                Map<String, dynamic> farmData = output;

                // Create UserModel instance using the user data
                FarmM farmn = FarmM.fromJson(farmData);
                // Navigator.pushNamed(context, '/farm_screen');
                setState(() {
                  farm = farmn;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => farmDetail(
                          farmlist: farm!,
                          networkHandler: networkHandler!,
                        )),
                  ),
                );
                print("updated");
                print(response.body);
                BotToast.showText(
                  text: "Farm Updated",
                  duration: Duration(seconds: 2),
                  contentColor: Colors.white,
                  textStyle:
                      TextStyle(fontSize: 16.0, color: Color(0xFF006837)),
                );
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     '/guest', (Route<dynamic> route) => false);
                // Navigator.of(context).pop();
              } else {
                print("faild");
                print(response.body.toString());
              }
            },
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
              controller: _farmName,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Farm Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: widget.farmlist.farmname,
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
              controller: _farmSize,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 3),
                labelText: "Farm size",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "${widget.farmlist.farmsize}",
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
              controller: _cropType,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Crop Type",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: widget.farmlist.croptype,
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
              controller: _soilType,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Soil Type",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: widget.farmlist.soiltype,
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
              controller: _polygonlocation,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Polygone",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "${widget.farmlist.longtude}",
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
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Location",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "${widget.farmlist.longtude}",
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
