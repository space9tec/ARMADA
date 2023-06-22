import 'package:armada/provider/location_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'configuration/routing.dart';
import 'configuration/theme_manager.dart';
import 'provider/drop_down_provider.dart';
import 'provider/drower_provider.dart';
import 'provider/item_provider.dart';
import 'provider/machine_status_provider.dart';
import 'view/screens/home_screen/guest_screen.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DropDownProvider()),
        ChangeNotifierProvider(create: (_) => ItemNotifire()),
        ChangeNotifierProvider(create: (_) => DrawerNotifire()),
        ChangeNotifierProvider(create: (_) => LocationSelectorProvider()),
        ChangeNotifierProvider(create: (_) => MachineStatusProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Armada',
        theme: customtheme(),
        onGenerateRoute: ROUTE.onGenerateRouth,
        initialRoute: Guest.routeName,
      ),
    );
  }
}
