import 'dart:convert';
import 'dart:ui';
import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import '../../../models/machine.dart';
import '../../../networkhandler.dart';
import '../../widgets/gustnavigationDrawer.dart';
import '../../widgets/widgets.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum InternetConnectionStatus { connected, disconnected }

class Guest extends StatefulWidget {
  static const String routeName = '/guest';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const Guest(),
    );
  }

  const Guest({super.key});

  @override
  State<Guest> createState() => _GuestState();
}

class _GuestState extends State<Guest> {
  NetworkHandler networkHandler = NetworkHandler();
  List<MachineM> machine = [];
  List<MachineM> displayedMachines = [];
  bool hasError = false;
  InternetConnectionStatus _connectionStatus =
      InternetConnectionStatus.connected;

  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;
  bool isfilter = false;

  List<String> images = [
    "assets/images/tracter1.png",
    "assets/images/tracter2.png",
    "assets/images/tracter3.png",
  ];
  late PageController _pageController;
  String userRole = 'farmer';
  int activePage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    checkInternetConnection();
    fetchData();
  }

  Future<void> checkInternetConnection() async {
    final isConnected = await InternetConnectionChecker().hasConnection;
    setState(() {
      _connectionStatus = isConnected
          ? InternetConnectionStatus.connected
          : InternetConnectionStatus.disconnected;
    });
  }

  void fetchData() async {
    try {
      var response = await networkHandler.get("/api/machinery/");

      setState(() {
        machine = (json.decode(response.body) as List)
            .map((data) => MachineM.fromJson(data))
            .toList();
        hasError = false;
      });
    } catch (e) {
      setState(() {
        // responseData = null;
        hasError = true;
      });
    }
  }

  void _performSearch(String searchQuery) {
    setState(() {
      if (searchQuery.isEmpty) {
        displayedMachines = List.from(machine);
      } else {
        displayedMachines = machine.where((machine) {
          return machine.manufacturer
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              machine.type.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildSearchResultsCard() {
    int itemCount = displayedMachines.length;
    double onehight = MediaQuery.of(context).size.height * 0.1;

    double cardHeight =
        itemCount > 0 ? (itemCount * 72.0) + onehight : onehight;
    cardHeight = cardHeight > 400.0 ? 400.0 : cardHeight;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          height: cardHeight,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search Results',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              if (itemCount != 0)
                Expanded(
                  child: ListView.builder(
                    itemCount: displayedMachines.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(displayedMachines[index].manufacturer),
                        subtitle: Text(displayedMachines[index].type),
                        // Add more details or customizations as needed
                      );
                    },
                  ),
                ),
              if (itemCount == 0)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Center(child: Text("No search result.")),
                )
            ],
          ),
        ),
      ),
    );
  }

  _custombottomSheetFilter(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.6,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Add a Filter",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          // Row(
          //   children: [
          //     Expanded(
          //         child: CustomButton(
          //       onTap: () {
          //         Navigator.pop(context);
          //       },
          //       text: "Cancel",
          //       color: Colors.black,
          //       textColor: Colors.white,
          //     )),
          //     SizedBox(
          //       width: 20,
          //     ),
          //     Expanded(
          //         child: CustomButton(
          //       onTap: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => Guest(),
          //             ));
          //       },
          //       text: "Done",
          //     ))
          //   ],
          // )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.width * 0.15),
          child: Column(
            children: [
              Text(
                "ARMADA",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        isSearching = value.isNotEmpty;
                      });
                      _performSearch(value);
                    },
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: isSearching
                          ? const Icon(
                              Icons.search,
                              color: Colors.white,
                            )
                          : const Icon(
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
                      suffixIcon: isSearching
                          ? IconButton(
                              icon: Icon(Icons.clear,
                                  color: Color.fromARGB(255, 6, 163, 90)),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  isSearching = false;
                                  displayedMachines = List.from(machine);
                                });
                              },
                            )
                          : GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context, '/search');
                                setState(() {
                                  showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25),
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      context: context,
                                      builder: (context) =>
                                          _custombottomSheetFilter(context));
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(7),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 117, 63),
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
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min

              children: [
                // Container(
                //   color: Colors.black.withOpacity(0.5),
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.27,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 192, 233, 192)
                                    .withOpacity(0.5),
                                blurRadius: 3,
                              ),
                            ],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.25,
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
                                    // Navigator.pushNamed(context, '/main_service');
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Image.asset(images[pagePosition])),
                                );
                              }),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: indicators(images.length, activePage))
                      ],
                    ),
                  ),
                ),
                addVerticalSpace(25),

                _connectionStatus == InternetConnectionStatus.connected
                    ? GridView.count(
                        physics:
                            const ClampingScrollPhysics(), // Remove NeverScrollableScrollPhysics
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.5,
                        shrinkWrap: true, // Added shrinkWrap property
                        children: List.generate(machine.length, (index) {
                          final machines = machine[index];
                          return CustomProductItemWidget(machines);
                        }),
                      )
                    : Text("No Internet Conection"),
              ],
            ),
          ),
          // if (isSearching)
          //   Positioned.fill(
          //     child: GestureDetector(
          //       onTap: () {
          //         FocusScope.of(context).unfocus();
          //         setState(() {
          //           isSearching = false;
          //         });
          //       },
          //       child: Container(
          //         color: Color.fromARGB(0, 255, 21, 21),
          //       ),
          //     ),
          //   ),
          if (isSearching)
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  isSearching = false;
                });
              },
              child: Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          if (isSearching)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                alignment: Alignment.topCenter,
                child: _buildSearchResultsCard(),
              ),
            ),
        ],
      ),
      drawer: gustnavigationDrawer(),
      bottomNavigationBar: gustbottomAppbar(context),
    );
  }
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
