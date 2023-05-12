import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class NewPassword extends StatefulWidget {
  static const String routeName = '/newpassword';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return const NewPassword();
      },
    );
  }

  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpace(89),
              Center(
                child: Text("New Password",
                    style: Theme.of(context).textTheme.displayLarge),
              ),
              addVerticalSpace(60),
              Center(
                child: Text(
                    "Your new password must be different\n              from the previous one.",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              addVerticalSpace(45),
              InputText(context, "New Password", true, Icons.lock_sharp,
                  TextInputType.text),
              addVerticalSpace(31.0),
              InputText(context, "Confirm Password", true, Icons.lock_sharp,
                  TextInputType.text),
              addVerticalSpace(170),
              Button(context, "Reset", '/login', Theme.of(context).primaryColor,
                  150, 55),
            ],
          ),
        ),
      ),
    );
  }
}
// 1000460208274 