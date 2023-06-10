import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import '../../../widgets/widgets.dart';

class ServiceProviderHomeScreen extends StatefulWidget {
  // till line 16 route code
  static const String routeName = '/serviceHome_Screen';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const ServiceProviderHomeScreen(),
    );
  }

  const ServiceProviderHomeScreen({super.key});

  @override
  State<ServiceProviderHomeScreen> createState() =>
      _ServiceProviderHomeScreenState();
}

class _ServiceProviderHomeScreenState extends State<ServiceProviderHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
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
          preferredSize: const Size.fromHeight(40),
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
                            ),
                          ),
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
        child: Column(
          children: [
            SizedBox(
              height: 600.0,
              child: Column(
                children: [
                  addVerticalSpace(25),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.5,
                      children: List.generate(
                        17,
                        (index) => CustomProductItemWidget(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      drawer: const ServiceProvidernavigationDrawer(),
      // bottom navbar
      bottomNavigationBar: ServiceProviderbottomAppbar(context),
      // ),
    );
  }
}
