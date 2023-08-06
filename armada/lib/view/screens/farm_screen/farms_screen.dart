import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../models/model.dart';
import '../../../networkhandler.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class FarmScreen extends StatefulWidget {
  static const String routeName = '/farm_screen';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const FarmScreen(),
    );
  }

  const FarmScreen({super.key});

  @override
  State<FarmScreen> createState() => _FarmScreenState();
}

class _FarmScreenState extends State<FarmScreen> {
  NetworkHandler networkHandler = NetworkHandler();
  final storage = const FlutterSecureStorage();

  List<FarmM> farm = [];
  bool fatched = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/api/farm/");

    String? userJson = await storage.read(key: 'userm');
    UserModel usermode = UserModel.fromJson(json.decode(userJson!));

    List<dynamic> responseData = json.decode(response.body);

    List<dynamic> filteredData = responseData
        .where((data) => data['owner_id'] == usermode.useid)
        .toList();
    if (mounted) {
      setState(() {
        farm = filteredData.map((data) => FarmM.fromJson(data)).toList();
        fatched = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Farm"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/display_notification');
            },
            icon: const Icon(Icons.notifications_sharp),
          ),
        ],
      ),
      body: fatched
          ? ListView.builder(
              itemCount: farm.length,
              itemBuilder: (BuildContext context, int index) {
                final farms = farm[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => farmDetail(
                              farmlist: farms,
                              networkHandler: networkHandler,
                            )),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        color: Colors.black.withOpacity(0.04),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://armada-server.glitch.me/api/farm/image/${farms.imagename}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Farm Name: ${farms.farmname}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Farm Size: ${farms.farmsize} - Location:\' ${farms.longtude}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : const _PreloadWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/upload_farm');
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: navigationDrawer(),
      bottomNavigationBar: bottomAppbar(context),
    );
  }
}

class _Skelton extends StatelessWidget {
  final double? height, width;
  const _Skelton({key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}

class _PreloadWidget extends StatelessWidget {
  const _PreloadWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        InkWell(
          onTap: () {},
          child: Column(
            children: [
              Row(
                children: [
                  _Skelton(
                    width: MediaQuery.of(context).size.width * 0.97,
                    height: MediaQuery.of(context).size.height * 0.19,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  _Skelton(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  _Skelton(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  _Skelton(
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  _Skelton(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
