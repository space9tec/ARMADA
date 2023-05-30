import 'package:armada/configuration/theme_manager.dart';
import 'package:armada/provider/item_provider.dart';
import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemPage extends StatefulWidget {
  static const String routeName = '/itemPage';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return ItemPage();
      },
    );
  }

  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  // final PageController pageController = PageController();
  late PageController pageController;

  int activePage = 1;
  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
  }

  List<String> images = [
    "assets/images/tracter1.png",
    "assets/images/tracter2.png",
    "assets/images/tracter3.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Consumer<ItemNotifire>(builder: (context, value, child) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                leadingWidth: 0,
                title: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                      GestureDetector(
                        onTap: null,
                        child: const Icon(Icons.more_horiz),
                      )
                    ],
                  ),
                ),
                pinned: true,
                snap: false,
                floating: true,
                backgroundColor: Colors.transparent,
                expandedHeight: MediaQuery.of(context).size.height,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.39,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey.shade300,
                              child: Image.asset(
                                fit: BoxFit.contain,
                                height: 100,
                                "assets/images/tracter1.png",
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.04,
                              right: 20,
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                            ),
                            // Positioned(
                            //   bottom: 0,
                            //   right: 0,
                            //   left: 0,
                            //   height:
                            //       MediaQuery.of(context).size.height * 0.3,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: List.generate(
                            //       4,
                            //       (index) => Padding(
                            //         padding:
                            //             EdgeInsets.symmetric(horizontal: 4),
                            //         child: CircleAvatar(
                            //           radius: 5,
                            //           backgroundColor:
                            //               value.activepage != index
                            //                   ? Colors.grey
                            //                   : Colors.black,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.605,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tracter",
                                    style: textTheme().displayMedium,
                                  ),
                                  addVerticalSpace(10),
                                  Text(
                                    "Owner :",
                                    style: textTheme().displayMedium,
                                  ),
                                  addVerticalSpace(10),

                                  Text(
                                    "Price : \$",
                                    style: textTheme().displayMedium,
                                  ),
                                  addVerticalSpace(10),

                                  Text(
                                    "Detail :-",
                                    style: textTheme().displayMedium,
                                  ),
                                  addVerticalSpace(10),

                                  Text(
                                    "Location - ",
                                    style: textTheme().displayMedium,
                                  ),
                                  addVerticalSpace(30),

                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     boxShadow: [
                                  //       BoxShadow(
                                  //         color: const Color.fromARGB(
                                  //                 255, 192, 233, 192)
                                  //             .withOpacity(0.5),
                                  //         // spreadRadius: 5,
                                  //         blurRadius: 3,
                                  //       ),
                                  //     ],
                                  //     borderRadius: const BorderRadius.all(
                                  //       Radius.circular(15),
                                  //     ),
                                  //   ),
                                  const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text("Related Items"),
                                  ),
                                  Container(
                                    width: 400,
                                    height: 200,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(16)),
                                                border: Border.all(
                                                  color: Colors.green,
                                                  width: 1,
                                                ),
                                              ),
                                              padding: EdgeInsets.all(10),
                                              width: 200,
                                              height: 200,
                                              margin: EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    fit: BoxFit.contain,
                                                    height: 80,
                                                    "assets/images/tracter1.png",
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Text(
                                                    'Item Name',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  const Text(
                                                    'Item Description',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: 20,
                                              right: 30,
                                              child: Column(
                                                children: [
                                                  const Icon(Icons.star,
                                                      color: Colors.yellow),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    '4.5',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Row(
                                                    children: const [
                                                      Text(
                                                        '100k+',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Icon(Icons
                                                          .thumb_up_alt_rounded),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),

                                  //   width:
                                  //       MediaQuery.of(context).size.width - 200,
                                  //   height: 150,
                                  //   child: PageView.builder(
                                  //       itemCount: images.length,
                                  //       controller: pageController,
                                  //       onPageChanged: (page) {
                                  //         setState(() {
                                  //           activePage = page;
                                  //         });
                                  //       },
                                  //       pageSnapping: true,
                                  //       itemBuilder: (context, pagePosition) {
                                  //         return GestureDetector(
                                  //           onTap: () {
                                  //             Navigator.pushNamed(
                                  //                 context, '/main_service');
                                  //           },
                                  //           child: Container(
                                  //               margin: const EdgeInsets.all(5),
                                  //               child: Image.asset(
                                  //                   images[pagePosition])),
                                  //         );
                                  //       }),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Positioned(
          bottom: 100,
          child: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {},
            elevation: 0,
            label: Text(
              "BOOK NOW",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
