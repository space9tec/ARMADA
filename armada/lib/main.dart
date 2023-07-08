import 'package:armada/provider/location_drop_down.dart';
import 'package:armada/view/screens/on_boarding/walk_through.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'configuration/routing.dart';
import 'configuration/theme_manager.dart';
import 'provider/authenticate.dart';
import 'provider/drop_down_provider.dart';
import 'provider/drower_provider.dart';
import 'provider/item_provider.dart';
import 'provider/machine_status_provider.dart';
import 'provider/user_provider.dart';
import 'provider/usermodel_provider.dart';
import 'view/screens/home_screen/guest_screen.dart';
import 'package:bot_toast/bot_toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final pref = await SharedPreferences.getInstance();
  final showHomw = pref.getBool("showHome") ?? false;
  runApp(MyApp(showHomw: showHomw));
}

class MyApp extends StatelessWidget {
  final bool showHomw;
  const MyApp({super.key, required this.showHomw});
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
        ChangeNotifierProvider(create: (_) => Authenticate()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Armada',
        theme: customtheme(),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        onGenerateRoute: ROUTE.onGenerateRouth,
        initialRoute: showHomw ? Guest.routeName : OnboardingPage.routeName,
      ),
    );
  }
}
