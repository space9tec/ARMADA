import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/helper_widget.dart';
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
  bool isLastpage = false;
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastpage = index == 2);
          },
          children: [
            buildPage(
              color: Colors.green,
              image: "assets/images/farmer_profile.png",
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
              image: "assets/images/farmer_profile.png",
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
                    MaterialPageRoute(builder: (context) => const Guest()));
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal.shade700,
                minimumSize:
                    Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(fontSize: 24),
              ))
          : Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        return controller.jumpToPage(2);
                      },
                      child: const Text('SKIP')),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                      onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut),
                      child: const Text('NEXT')),
                ],
              ),
            ),
    );
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
            addVerticalSpace(MediaQuery.of(context).size.height * 0.06),
            Text(
              title,
              style: TextStyle(
                  color: Colors.teal.shade700,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            // addVerticalSpace(MediaQuery.of(context).size.height * 0.02),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
}
