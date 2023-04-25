import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:armada/view/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../provider/drop_down_provider.dart';

class SignUp extends StatefulWidget {
  static const String routeName = '/signup';

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
              addVerticalSpace(30.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text(
                      "Sign Up",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ],
              ),
              addVerticalSpace(20.0),
              InputText(context, "Full name", false, Icons.person_3_sharp,
                  TextInputType.name),
              addVerticalSpace(21.0),
              InputText(context, "Phone", false, Icons.phone_sharp,
                  TextInputType.phone),
              addVerticalSpace(21.0),
              InputText(context, "Email (optional)", false, Icons.email_sharp,
                  TextInputType.emailAddress),
              addVerticalSpace(21.0),
              Container(
                width: MediaQuery.of(context).size.width - 120,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 322,
                      // padding: EdgeInsets.only(right: 28.0),
                      child: Text(
                        "Account ",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Consumer<DropDownProvider>(
                      builder: (context, value, child) => Container(
                        width: MediaQuery.of(context).size.width - 210,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: DropdownButtonFormField(
                          value: value.selectedAccount,
                          items: value.accountType
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(e),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            value.setAccountType(val);
                          },
                          decoration: InputDecoration(border: InputBorder.none),
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.grey,
                          ),
                          icon: const Padding(
                            padding: EdgeInsets.only(right: 15.0),
                            child: Icon(
                              Icons.arrow_drop_down_circle_sharp,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              addVerticalSpace(21.0),
              InputText(context, "Password", true, Icons.lock_sharp,
                  TextInputType.text),
              addVerticalSpace(21.0),
              InputText(context, "Confirm Password", true, Icons.lock_sharp,
                  TextInputType.text),
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
              addVerticalSpace(10.0),
              Button(context, "Register"),
              addVerticalSpace(24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account. ",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  addVerticalSpace(1.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      " login",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
