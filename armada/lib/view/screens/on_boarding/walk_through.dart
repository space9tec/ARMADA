import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../home_screen/guest_screen.dart';

class OnboardingPage extends StatefulWidget {
  static const String routeName = '/onboarding';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const OnboardingPage(),
    );
  }

  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool isLastpage = false;
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required Color color,
    required String image,
    required String title,
    required String subtitle,
  }) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            SizedBox(
              height: 64,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.teal.shade700,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
                child: Text(
                  subtitle,
                  style: TextStyle(
                      color: Colors.teal.shade700,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastpage = index == 2);
          },
          children: [
            buildPage(
              color: Colors.green,
              image: "assets/images/farmer1.png",
              title: "Welcome to ARMADA",
              subtitle: "Find the perfect machinery for your field",
            ),
            buildPage(
              color: Colors.green,
              image: "assets/images/tracter1.png",
              title: "Simplify Your Life",
              subtitle: "With ARMADA's Easy Booking Process",
            ),
            buildPage(
              color: Colors.green,
              image: "assets/images/farmer1.png",
              title: "Communicate with ease",
              subtitle:
                  "Join our community of farmers and machinery owners today!",
            ),
          ],
        ),
      ),
      bottomSheet: isLastpage
          ? TextButton(
              onPressed: () async {
                final pref = await SharedPreferences.getInstance();
                pref.setBool("showHome", true);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Guest()));
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal.shade700,
                minimumSize: Size.fromHeight(80),
              ),
              child: Text(
                "Get Started",
                style: TextStyle(fontSize: 24),
              ))
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        return controller.jumpToPage(2);
                      },
                      child: Text('SKIP')),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                      onPressed: () => controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOut),
                      child: Text('NEXT')),
                ],
              ),
            ),
    );
  }
}
