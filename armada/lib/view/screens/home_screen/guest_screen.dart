import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import '../../widgets/gustnavigationDrawer.dart';
import '../../widgets/widgets.dart';

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
  late PageController _pageController;
  String userRole = 'farmer';
  List<String> images = [
    "assets/images/tracter1.png",
    "assets/images/tracter2.png",
    "assets/images/tracter3.png",
  ];
  int activePage = 1;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
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
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  children: [
                    Column(
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
                                    Navigator.pushNamed(
                                        context, '/main_service');
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
                    addVerticalSpace(25),
                    Expanded(
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.5,
                        children: List.generate(
                          5,
                          (index) => CustomProductItemWidget(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
