import 'dart:convert';

import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/machine.dart';
import '../../../models/usermodel.dart';
import '../../../networkhandler.dart';
import '../../../provider/drop_down_provider.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';
import 'guest_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../models/farm.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const HomeScreen(),
    );
  }

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NetworkHandler networkHandler = NetworkHandler();
  List<MachineM> machine = [];
  List<FarmM> farm = [];

  UserModel usermode = UserModel(
      firstname: '',
      password: '',
      lastname: '',
      phone: '',
      useid: '',
      image: '');
  void initState() {
    _pageController = PageController(viewportFraction: 0.8);

    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/api/machinery/");

    String? userJson = await storage.read(key: 'userm');

    if (userJson != null) {
      // Convert JSON to UserModel
      usermode = UserModel.fromJson(json.decode(userJson));

      // Use the storedUser object as needed in your application
      print('Stored user: ${usermode.firstname} ${usermode.lastname}');
    }
    setState(() {
      machine = (json.decode(response.body) as List)
          .map((data) => MachineM.fromJson(data))
          .toList();
    });
//farm
    var responsefarm = await networkHandler.get("/api/farm/");

    // setState(() {
    //   farm = (json.decode(response.body) as List)
    //       .map((data) => FarmM.fromJson(data))
    //       .toList();
    // });
    // String? ownerid = await storage.read(key: "userid");
    String? user = await storage.read(key: 'userm');
    UserModel usermodel = UserModel.fromJson(json.decode(user!));

    List<dynamic> responseDatam = json.decode(responsefarm.body);

    List<dynamic> filteredData = responseDatam
        .where((data) => data['owner_id'] == usermodel.useid)
        .toList();

    setState(() {
      farm = filteredData.map((data) => FarmM.fromJson(data)).toList();
    });
  }

  late PageController _pageController;
  String? userRole;
  List<String> images = [
    "assets/images/tracter1.png",
    "assets/images/tracter2.png",
    "assets/images/tracter3.png",
  ];
  final storage = new FlutterSecureStorage();

  int activePage = 1;
  bool circulat = false;

  @override
  Widget build(BuildContext context) {
    switch (
        Provider.of<DropDownProvider>(context, listen: false).selectedAccount) {
      case 'Service Provider':
        return ServiceProviderHomeScreen();
      case 'Farmer':
        return DefaultTabController(
          length: farm.length + 1,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/display_notification');
                  },
                  icon: const Icon(Icons.notifications_sharp),
                ),
              ],
              bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.width * 0.26),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 6, 163, 90),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.green,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.green,
                              ),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/search');
                              },
                              child: Container(
                                margin: const EdgeInsets.all(7),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: const Center(
                                    child: Icon(
                                  Icons.filter_list_sharp,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TabBar(
                      tabs: [
                        Tab(text: 'All'),
                        // Tab(text: usermode.firstname),
                        ...farm
                            .map((farm) => Tab(text: farm.farmname))
                            .toList(),
                        // Tab(text: 'Location 2'),
                      ],
                      // isScrollable: true,
                      indicatorColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 3,
                      labelColor: Colors.white,
                      labelStyle: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.79,
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 192, 233, 192)
                                          .withOpacity(0.5),
                                  blurRadius: 3,
                                ),
                              ],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.24,
                            child: PageView.builder(
                                itemCount: images.length,
                                controller: _pageController,
                                onPageChanged: (page) {
                                  setState(() {
                                    activePage = page;
                                  });
                                },
                                pageSnapping: true,
                                itemBuilder: (context, pagePosition) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigator.pushNamed(
                                      //     context, '/main_service');
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.all(5),
                                        child:
                                            Image.asset(images[pagePosition])),
                                  );
                                }),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: indicators(images.length, activePage)),
                          addVerticalSpace(25),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.5,
                            children: List.generate(machine.length, (index) {
                              final machines = machine[index];
                              return CustomProductItemWidget(machines);
                            }),
                          ),
                        ],
                      ),
                    ),
                    ...farm.map((farm) => buildFarmWidget(farm)).toList(),
                    // const Center(child: Text("Insert Your farm location")),
                  ],
                ),
              ),
            ),
            drawer: navigationDrawer(),
            bottomNavigationBar: bottomAppbar(context),
          ),
        );
      default:
        return const Guest();
    }
  }
}

Widget buildFarmWidget(FarmM farm) {
  // Replace with your implementation for each farm tab
  return Container(
    child: Center(
      child: Text('Farm Widget for ${farm.croptype}'),
    ),
  );
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}
