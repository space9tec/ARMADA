import 'package:armada/provider/location_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'configuration/routing.dart';
import 'configuration/theme_manager.dart';
import 'provider/drop_down_provider.dart';
import 'provider/drower_provider.dart';
import 'provider/item_provider.dart';
import 'provider/machine_status_provider.dart';
import 'provider/user_provider.dart';
import 'provider/usermodel_provider.dart';
import 'view/screens/home_screen/guest_screen.dart';
import 'package:bot_toast/bot_toast.dart';

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
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => UserMProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Armada',
        theme: customtheme(),
        builder: BotToastInit(), // Initialize BotToast here
        navigatorObservers: [BotToastNavigatorObserver()],
        onGenerateRoute: ROUTE.onGenerateRouth,
        initialRoute: Guest.routeName,
      ),
    );
  }
}
