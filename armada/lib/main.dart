import 'package:armada/view/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'configuration/routing.dart';
import 'configuration/theme_manager.dart';
import 'provider/drop_down_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DropDownProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Armada',
        theme: customtheme(),
        onGenerateRoute: ROUTE.onGenerateRouth,
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}
