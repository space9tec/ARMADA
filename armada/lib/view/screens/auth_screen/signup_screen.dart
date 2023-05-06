import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:armada/view/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../provider/drop_down_provider.dart';

class SignUp extends StatefulWidget {
  static const String routeName = '/signup';

// till line 19 route code
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return const SignUp();
      },
    );
  }

  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpace(55.0),
              Center(
                child: Text("Create Account.",
                    style: Theme.of(context).textTheme.displayLarge),
              ),
              addVerticalSpace(50.0),
              InputText(context, "Full name", false, Icons.person_3_sharp,
                  TextInputType.name),
              addVerticalSpace(21.0),
              InputText(context, "Phone", false, Icons.phone_sharp,
                  TextInputType.phone),
              addVerticalSpace(21.0),
              InputText(context, "Email (optional)", false, Icons.email_sharp,
                  TextInputType.emailAddress),
              addVerticalSpace(21.0),
              InputText(context, "Password", true, Icons.lock_sharp,
                  TextInputType.text),
              addVerticalSpace(21.0),
              InputText(context, "Confirm Password", true, Icons.lock_sharp,
                  TextInputType.text),
              addVerticalSpace(21.0),
              accountSelector(context),
              addVerticalSpace(10.0),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: value,
                      onChanged: (bool? value) {
                        setState(() {
                          this.value = value!;
                        });
                      },
                    ),
                  ),
                  Text(
                    "I agree to the term and condition",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              addVerticalSpace(20.0),
              Button(context, "Register", '/verify'),
              addVerticalSpace(24.0),
              Text(
                "Already have an account.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              addVerticalSpace(1.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  "Login",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
