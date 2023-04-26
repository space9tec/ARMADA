import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/widgets.dart';

class Verify extends StatefulWidget {
  static const String routeName = '/verify';
  const Verify({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return const Verify();
      },
    );
  }

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpace(89),
              Center(
                child: Text("Verify Your Phone.",
                    style: Theme.of(context).textTheme.displayLarge),
              ),
              addVerticalSpace(60),
              Center(
                child: Text(
                    "Enter the verification code sent\n         to your phone number.",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              addVerticalSpace(45),
              Form(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 68.0,
                        width: 64.0,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          onSaved: (pin1) {},
                          style: Theme.of(context).textTheme.displayLarge,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.green,
                                )),
                            contentPadding: EdgeInsets.only(bottom: 25),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.green,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 68.0,
                        width: 64.0,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          onSaved: (pin2) {},
                          style: Theme.of(context).textTheme.displayLarge,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.green,
                                )),
                            contentPadding: EdgeInsets.only(bottom: 25),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.green,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 68.0,
                        width: 64.0,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          onSaved: (pin3) {},
                          style: Theme.of(context).textTheme.displayLarge,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.green,
                                )),
                            contentPadding: EdgeInsets.only(bottom: 25),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.green,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 68.0,
                        width: 64.0,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          onSaved: (pin4) {},
                          style: Theme.of(context).textTheme.displayLarge,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.green,
                                )),
                            contentPadding: EdgeInsets.only(bottom: 25),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.green,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              addVerticalSpace(32),
              Text(
                "60 s",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              addVerticalSpace(26),
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
              addVerticalSpace(126),
              Button(context, "Verify", '/'),
            ],
          ),
        ),
      ),
    );
  }
}
