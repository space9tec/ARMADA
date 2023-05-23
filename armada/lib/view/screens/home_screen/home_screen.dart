import 'package:armada/models/viewModel/drawerModel.dart';

import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  // till line 16 route code
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => HomeScreen(),
    );
  }

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  List<String> images = [
    "assets/images/tracter1.png",
    "assets/images/tracter1.png",
    "assets/images/tracter1.png",
  ];
  int activePage = 1;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // appbar
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/display_notification');
              },
              icon: Icon(Icons.notifications_sharp),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: Column(
              children: [
                // locationSelector(context),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 65,
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
                          color: Color.fromARGB(255, 10, 190, 106),
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
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.green,
                          ),
                        ),
                        suffixIcon: Container(
                          margin: EdgeInsets.all(7),
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

                // SizedBox(
                //   width: MediaQuery.of(context).size.width - 300,
                //   height: 65,
                //   child: Padding(
                //     padding: const EdgeInsets.all(10.0),
                //     child: TextField(
                //       style: const TextStyle(
                //         color: Colors.grey,
                //       ),
                //       decoration: InputDecoration(
                //         hintText: 'Search',
                //         prefixIcon: const Icon(
                //           Icons.search,
                //           color: Color.fromARGB(255, 10, 190, 106),
                //         ),
                //         border: InputBorder.none,
                //         contentPadding: EdgeInsets.zero,
                //         filled: true,
                //         fillColor: Colors.white,
                //         focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(15),
                //             borderSide: const BorderSide(
                //               width: 1,
                //               color: Colors.green,
                //             )),
                //         enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(15),
                //           borderSide: const BorderSide(
                //             width: 1,
                //             color: Colors.green,
                //           ),
                //         ),
                //         suffixIcon: Container(
                //           margin: EdgeInsets.all(7),
                //           height: 30,
                //           width: 30,
                //           decoration: BoxDecoration(
                //             color: Theme.of(context).primaryColor,
                //             borderRadius: BorderRadius.circular(9),
                //           ),
                //           child: const Center(
                //               child: Icon(
                //             Icons.filter_list_sharp,
                //             color: Colors.white,
                //           )),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                const TabBar(tabs: [
                  Tab(text: 'All'),
                  Tab(text: 'Location 1'),
                  Tab(text: 'Location 2'),
                ])
              ],
            ),
          ),
        ),
        body: TabBarView(children: [
          Center(
            child: Container(
                child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
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
                                Navigator.pushNamed(context, '/main_service');
                              },
                              child: Container(
                                  margin: EdgeInsets.all(5),
                                  child: Image.asset(images[pagePosition])),
                            );
                          }),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: indicators(images.length, activePage))
                  ],
                ),
              ],
            )),
          ),
          Center(child: Text("Insert Your farm location")),
          Center(child: Text("Insert Your farm location")),
          // Container(
          //     child: Column(
          //   children: [
          //     Column(tel
          //       children: [
          //         SizedBox(
          //           width: MediaQuery.of(context).size.width,
          //           height: 200,
          //           child: PageView.builder(
          //               itemCount: images.length,
          //               controller: _pageController,
          //               onPageChanged: (page) {
          //                 setState(() {
          //                   activePage = page;
          //                 });
          //               },
          //               pageSnapping: true,
          //               itemBuilder: (context, pagePosition) {
          //                 return GestureDetector(
          //                   onTap: () {
          //                     Navigator.pushNamed(context, '/main_service');
          //                   },
          //                   child: Container(
          //                       margin: EdgeInsets.all(5),
          //                       child: Image.asset(images[pagePosition])),
          //                 );
          //               }),
          //         ),
          //         Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: indicators(images.length, activePage))
          //       ],
          //     ),
          //   ],
          // )),
        ]),
        // side drawer
        drawer: navigationDrawer(),
        // bottom navbar
        bottomNavigationBar: bottomAppbar(context),
      ),
    );
  }
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}
