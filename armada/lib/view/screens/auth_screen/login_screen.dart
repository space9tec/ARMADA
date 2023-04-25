import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:armada/view/widgets/widgets.dart';

class Login extends StatefulWidget {
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return const Login();
      },
    );
  }

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              addVerticalSpace(95.0),
              Center(
                child: Text("Welcome.",
                    style: Theme.of(context).textTheme.displayLarge),
              ),
              addVerticalSpace(80.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text(
                      "Sign in",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ],
              ),
              addVerticalSpace(64.0),
              InputText(context, "Phone", false, Icons.phone_sharp,
                  TextInputType.phone),
              addVerticalSpace(31.0),
              InputText(context, "Password", true, Icons.lock_sharp,
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
                    "remember me?",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              addVerticalSpace(8.0),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forget password? ",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "Reset",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              ),
              addVerticalSpace(60.0),
              Button(context, "LogIn"),
              addVerticalSpace(24.0),
              Text(
                "Don't have an account?",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              addVerticalSpace(1.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  "Create an account",
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
