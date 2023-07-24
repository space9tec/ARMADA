import 'package:armada/view/screens/home_screen/guest_screen.dart';
import 'package:armada/view/screens/screens.dart';
import 'package:flutter/material.dart';

import '../services/tokenManager.dart';
// import '../view/screens/home_screen/guest_screen.dart';

class AuthGuard extends StatefulWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const AuthGuard(),
    );
  }

  const AuthGuard({super.key});
  // final Widget Function(BuildContext context) builder;

  // const AuthGuard({required this.builder});

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: TokenManager().getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator if the token is being fetched.
          print("1");

          return CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data != null) {
          // Token is available, allow access to the desired page.
          print("2");
          print(snapshot.data);
          return HomeScreen();
        } else {
          // No token available, redirect to the guest page.
          print("3");

          return Guest();
        }
      },
    );
  }
}
