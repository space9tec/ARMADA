import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class ForgetPassword extends StatefulWidget {
  static const String routeName = '/forgetpassword';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return const ForgetPassword();
      },
    );
  }

  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
                child: Text("Forget Password.",
                    style: Theme.of(context).textTheme.displayLarge),
              ),
              addVerticalSpace(60),
              Center(
                child: Text(
                    "Enter the verification code sent\n         to your phone number.",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              addVerticalSpace(45),
              SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                height: 50,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.green,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.green,
                        )),
                  ),
                ),
              ),
              addVerticalSpace(62),
              Text(
                "Did't recieve the code?",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              addVerticalSpace(1.0),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Resend",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              addVerticalSpace(170),
              Button(context, "Continue", '/newpassword'),
            ],
          ),
        ),
      ),
    );
  }
}
