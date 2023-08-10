import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../models/model.dart';
import '../../../networkhandler.dart';
import '../../../utils/helper_widget.dart';
import '../../widgets/widgets.dart';
import '../../../provider/provider.dart';
import '../screens.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

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
  final storage = const FlutterSecureStorage();
  final TextEditingController _searchController = TextEditingController();
  late PageController _pageController;

  List<FarmM> farm = [];
  List<MachineM> machine = [];
  List<MachineM> machinefilter = [];
  List<MachineM> filteredMachines = [];
  List<MachineM> displayedMachines = [];

  bool filt = false;
  int activePage = 1;
  bool circulat = false;
  bool isSearching = false;
  bool loading = false;

  double minValue = 400;
  double maxValue = 3400;
  RangeValues rangevalue = const RangeValues(400, 3400);

  List<String> images = [
    "assets/images/tracter1.png",
    "assets/images/tracter2.png",
    "assets/images/tracter3.png",
  ];
  UserModel usermode = const UserModel(
      firstname: '',
      password: '',
      lastname: '',
      phone: '',
      useid: '',
      image: '');

  final _regions = [
    "select",
    'Tigray',
    'Afar',
    "Amhara",
    "Oromia",
    "Somali",
    "SNNPR",
    "Gambela",
    "Benishangul",
    "Harari"
  ];
  String _selectedregion = "select";

  final _machinetype = [
    "select",
    'Tractor',
    'Combine Harvester',
    "Thresher",
    "Tractor Attachment",
    "Other"
  ];
  String _selectedmachinetype = "select";

  final _attachmenttype = [
    "select",
    'Disc Plough',
    'Disc Harrow',
    "Planter",
    "Sprayer",
    "Baler",
    "Trailer",
    "Other",
  ];
  String _selectedattachmenttype = "select";

  final _statusttype = [
    "select",
    'Available',
    'In Maintenance',
    "Booked",
  ];
  String _selectedstatustype = "select";

  @override
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
    }
    if (mounted) {
      setState(() {
        machine = (json.decode(response.body) as List)
            .map((data) => MachineM.fromJson(data))
            .toList();

        loading = true;
      });
    }

    var responsefarm = await networkHandler.get("/api/farm/");

    List<dynamic> responseDatam = json.decode(responsefarm.body);

    List<dynamic> filteredData = responseDatam
        .where((data) => data['owner_id'] == usermode.useid)
        .toList();
    if (mounted) {
      setState(() {
        farm = filteredData.map((data) => FarmM.fromJson(data)).toList();
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

  void _applyFilters() {
    setState(() {
      filteredMachines = machine.where((machine) {
        bool regionMatches =
            _selectedregion == "select" || machine.region == _selectedregion;
        bool typeMatches = _selectedmachinetype == "select" ||
            machine.type == _selectedmachinetype;
        bool attachmentMatches = _selectedattachmenttype == "select" ||
            machine.attachmenttype == _selectedattachmenttype;

        return regionMatches && typeMatches && attachmentMatches;
      }).toList();
      filt = true;
    });

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      controller: _searchController,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      onChanged: (value) {
                        setState(() {
                          isSearching = value.isNotEmpty;
                        });
                        _performSearch(value);
                      },
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
                                icon: const Icon(Icons.clear,
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
                                  setState(() {
                                    showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25),
                                          ),
                                        ),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        context: context,
                                        builder: (context) =>
                                            _custombottomSheetFilter(context));
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(7),
                                  height:
                                      MediaQuery.of(context).size.height * 0.09,
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 0, 117, 63),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Center(
                                      child: Icon(
                                    size: MediaQuery.of(context).size.width *
                                        0.08,
                                    Icons.filter_alt,
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
                    const Tab(text: 'All'),
                    ...farm.map((farm) => Tab(text: farm.longtude)).toList(),
                  ],
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
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.68,
                child: filt
                    ? TabBarView(children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GridView.count(
                                physics: const ClampingScrollPhysics(),
                                crossAxisCount: 2,
                                childAspectRatio: 1 / 1.5,
                                shrinkWrap: true,
                                children: List.generate(filteredMachines.length,
                                    (index) {
                                  final filteredMachine =
                                      filteredMachines[index];
                                  return CustomProductItemWidget(
                                      filteredMachine);
                                }),
                              )
                            ],
                          ),
                        ),
                        ...farm
                            .map((farm) => buildFarmWidget(
                                farm, context, filteredMachines))
                            .toList(),
                      ])
                    : TabBarView(
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(
                                decelerationRate: ScrollDecelerationRate.fast),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 192, 233, 192)
                                            .withOpacity(0.5),
                                        blurRadius: 3,
                                      ),
                                    ],
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.24,
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
                                          onTap: () {},
                                          child: Container(
                                              margin: const EdgeInsets.all(5),
                                              child: Image.asset(
                                                  images[pagePosition])),
                                        );
                                      }),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                        indicators(images.length, activePage)),
                                addVerticalSpace(15),
                                loading
                                    ? Center(
                                        child: GridView.count(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          crossAxisCount: 2,
                                          childAspectRatio: 1 / 1.4,
                                          children: List.generate(
                                              machine.length, (index) {
                                            final machines = machine[index];
                                            return CustomProductItemWidget(
                                                machines);
                                          }),
                                        ),
                                      )
                                    : Center(
                                        child: GridView.count(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            crossAxisCount: 2,
                                            childAspectRatio: 1 / 1.4,
                                            children: List.generate(6, (index) {
                                              return const _PreloadWidget();
                                            })),
                                      ),
                              ],
                            ),
                          ),
                          ...farm
                              .map((farm) =>
                                  buildFarmWidget(farm, context, machine))
                              .toList(),
                        ],
                      ),
              ),
            ),
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
        drawer: navigationDrawer(),
        bottomNavigationBar: bottomAppbar(context),
      ),
    );
  }

  Widget _buildSearchResultsCard() {
    int itemCount = displayedMachines.length;
    double onehight = MediaQuery.of(context).size.height * 0.1;

    double cardHeight =
        itemCount > 0 ? (itemCount * 72.0) + onehight : onehight;
    cardHeight = cardHeight > 400.0 ? 400.0 : cardHeight;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: cardHeight,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Search Results',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              if (itemCount != 0)
                Expanded(
                  child: ListView.builder(
                    itemCount: displayedMachines.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => ItemPage(
                                    machineid:
                                        displayedMachines[index].machineId)),
                              ));
                        },
                        child: ListTile(
                          title: Text(displayedMachines[index].manufacturer),
                          subtitle: Text(displayedMachines[index].type),
                          trailing: Text(displayedMachines[index].status),
                          leading: Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.14,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "https://armada-server.glitch.me/api/machinery/image/${displayedMachines[index].imageFile}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              if (itemCount == 0)
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Center(child: Text("No search result.")),
                )
            ],
          ),
        ),
      ),
    );
  }

  _custombottomSheetFilter(BuildContext context) {
    final rangeValuesProvider = Provider.of<RangeValuesProvider>(context);
    final rangeValues = rangeValuesProvider.currentRangeValues;
    return Container(
      padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel))),
                  const Text("Filter"),
                  const Text("Clear All")
                ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.37,
                child: DropdownButtonFormField(
                  value: _selectedregion,
                  items: _regions
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedregion = val as String;
                    });
                  },
                  icon: const Icon(Icons.arrow_drop_down_circle),
                  decoration: InputDecoration(
                    labelText: "Region",
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF006837),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF006837),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 35,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.43,
                height: MediaQuery.of(context).size.height * 0.07,
                child: DropdownButtonFormField(
                  value: _selectedstatustype,
                  items: _statusttype
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedstatustype = val as String;
                    });
                  },
                  icon: const Icon(Icons.arrow_drop_down_circle),
                  decoration: InputDecoration(
                    labelText: "Status",
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF006837),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF006837),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.38,
                height: MediaQuery.of(context).size.height * 0.07,
                child: DropdownButtonFormField(
                  value: _selectedattachmenttype,
                  items: _attachmenttype
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedattachmenttype = val as String;
                    });
                  },
                  icon: const Icon(Icons.arrow_drop_down_circle),
                  decoration: InputDecoration(
                    labelText: "Attachment Type",
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xFF006837),
                        )),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF006837),
                      ),
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.51,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: IgnorePointer(
                      ignoring: false,
                      child: DropdownButtonFormField(
                        value: _selectedmachinetype,
                        items: _machinetype
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedmachinetype = val as String;
                          });
                        },
                        icon: const Icon(Icons.arrow_drop_down_circle),
                        decoration: InputDecoration(
                          labelText: "Machine type",
                          labelStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Color(0xFF006837),
                              )),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xFF006837),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: 0,
                    duration: const Duration(milliseconds: 200),
                    child: _buildDisabledMessage(),
                  ),
                ],
              ),
            ],
          ),
          InputDecorator(
            decoration: InputDecoration(
              labelText: "Horse power",
              labelStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Color(0xFF006837),
                  )),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFF006837),
                ),
              ),
            ),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.07,
                child: Row(
                  children: [
                    const Text("400"),
                    Expanded(
                      child: RangeSlider(
                        values: rangeValues,
                        min: 400,
                        max: 3500,
                        activeColor: Colors.black,
                        labels: RangeLabels(
                          rangeValues.start.toString(),
                          rangeValues.end.toString(),
                        ),
                        divisions:
                            100, // Number of divisions between min and max values

                        onChanged: (RangeValues values) {
                          rangeValuesProvider.setCurrentRangeValues(values);
                        },
                      ),
                    ),
                    const Text("3500"),
                  ],
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: _applyFilters,
            child: SizedBox(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.63,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).primaryColor,
                ),
                child: const Center(
                  child: Text(
                    "Filter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildDisabledMessage() {
  return Container(
    alignment: Alignment.center,
    child: const Text(
      'Dropdown is disabled',
      style: TextStyle(color: Colors.grey),
    ),
  );
}

class Skelton extends StatelessWidget {
  final double? height, width;
  const Skelton({key, this.height, this.width}) : super(key: key);

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
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.27,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Skelton(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2),
        const SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skelton(width: MediaQuery.of(context).size.width * 0.4),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Skelton(width: MediaQuery.of(context).size.width * 0.15),
            addHorizontalSpace(5),
            Skelton(width: MediaQuery.of(context).size.width * 0.2),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Skelton(width: MediaQuery.of(context).size.width * 0.15),
            Skelton(width: MediaQuery.of(context).size.width * 0.25),
          ],
        ),
      ]),
    );
  }
}

Widget buildFarmWidget(
    FarmM farm, BuildContext context, List<MachineM> machine) {
  List<MachineM> machinefilter = machine.where((data) {
    return data.region == farm.longtude;
  }).toList();
  return SingleChildScrollView(
    child: Column(
      children: [
        addVerticalSpace(25),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.5,
          children: List.generate(machinefilter.length, (index) {
            final machines = machinefilter[index];

            return CustomProductItemWidget(machines);
          }),
        ),
      ],
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
