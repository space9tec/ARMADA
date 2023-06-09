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
      ),
      body: Container(),

      drawer: const ServiceProvidernavigationDrawer(),
      // bottom navbar
      bottomNavigationBar: ServiceProviderbottomAppbar(context),
      // ),
    );
  }
}
