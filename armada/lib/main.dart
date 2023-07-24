import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:bot_toast/bot_toast.dart';

import 'configuration/routing_manager.dart';
import 'configuration/theme_manager.dart';

import 'provider/provider.dart';
import 'utils/auth_guard.dart';
import 'view/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final pref = await SharedPreferences.getInstance();
  final showHome = pref.getBool("showHome") ?? false;

  final themeProvider = ThemeProvider();
  await themeProvider.loadThemeMode();

  runApp(
    ChangeNotifierProvider(
      create: (_) => themeProvider,
      child: MyApp(showHomw: showHome),
    ),
  );
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
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Armada',
            theme: CustomTheme().getTheme(themeProvider.currentThemeMode),
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            onGenerateRoute: ROUTESM.onGenerateRouth,
            initialRoute:
                showHomw ? AuthGuard.routeName : OnboardingPage.routeName,
          );
        },
      ),
    );
  }
}
