import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:armada/view/widgets/widgets.dart';

class VerifyFarm extends StatefulWidget {
  static const String routeName = '/VerifyFarm';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return const VerifyFarm();
      },
    );
  }

  const VerifyFarm({super.key});

  @override
  State<VerifyFarm> createState() => _VerifyFarmState();
}

class _VerifyFarmState extends State<VerifyFarm> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpace(45.0),
              InputText(context, "Farm name", false, Icons.phone_sharp,
                  TextInputType.phone),
              addVerticalSpace(31.0),
              InputText(context, "Farm size", true, Icons.lock_sharp,
                  TextInputType.text),
              addVerticalSpace(31.0),
              InputText(context, "Farm Location", true, Icons.lock_sharp,
                  TextInputType.text),
              addVerticalSpace(31.0),
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Optinal",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
              addVerticalSpace(31.0),
              InputText(context, "Crop type", true, Icons.lock_sharp,
                  TextInputType.text),
              addVerticalSpace(31.0),
              InputText(context, "Soil Type", true, Icons.lock_sharp,
                  TextInputType.text),
              addVerticalSpace(31.0),
              InputText(
                  context, "hello", true, Icons.lock_sharp, TextInputType.text),
              addVerticalSpace(40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(context, "Verify", '/', Theme.of(context).primaryColor,
                      325, 40),
                  addHorizontalSpace(25),
                  Button(context, "cancel", '/', Colors.grey, 325, 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
