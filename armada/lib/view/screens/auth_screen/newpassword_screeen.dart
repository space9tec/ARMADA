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
  final formKey = GlobalKey<FormState>();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmPasswordcontroller =
      TextEditingController();
  bool value = false;
  bool isHidden = true;
  bool isHiddenConfirm = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Form(
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
                SizedBox(
                  width: MediaQuery.of(context).size.width - 120,
                  height: 67,
                  child: TextFormField(
                    controller: _passwordcontroller,
                    keyboardType: TextInputType.text,
                    obscureText: isHidden,
                    validator: (value) {
                      if (value == null || value.length < 4) {
                        return "More than 4 character needed";
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                    ),
                    decoration: InputDecoration(
                      labelText: "password",
                      labelStyle: const TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_sharp,
                        color: Color.fromARGB(255, 10, 190, 106),
                      ),
                      suffixIcon: IconButton(
                        onPressed: _togglePasswordView,
                        icon: isHidden
                            ? const Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: Color.fromARGB(255, 10, 190, 106),
                              ),
                      ),
                      // errorText: etext,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.green,
                          )),
                    ),
                  ),
                ),
                addVerticalSpace(15.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 120,
                  height: 67,
                  child: TextFormField(
                    controller: _confirmPasswordcontroller,
                    keyboardType: TextInputType.text,
                    obscureText: isHiddenConfirm,
                    validator: (value) {
                      if (value == null || value.length < 4) {
                        return "More than 4 character needed";
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                    ),
                    decoration: InputDecoration(
                      labelText: "Confirm password",
                      labelStyle: const TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_sharp,
                        color: Color.fromARGB(255, 10, 190, 106),
                      ),
                      suffixIcon: IconButton(
                        onPressed: _toggleConfirmPasswordView,
                        icon: isHiddenConfirm
                            ? Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              )
                            : Icon(
                                Icons.visibility,
                                color: Color.fromARGB(255, 10, 190, 106),
                              ),
                      ),
                      // errorText: etext,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                addVerticalSpace(170),
                Container(
                  child: InkWell(
                    onTap: () {
                      // Navigator.pushNamed(context, routh);
                      if (formKey.currentState!.validate()) {
                        Map<String, String> data = {
                          "password": _passwordcontroller.text,
                        };
                        print(data);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 150,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: const Center(
                        child: Text(
                          "Reset",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  void _toggleConfirmPasswordView() {
    setState(() {
      isHiddenConfirm = !isHiddenConfirm;
    });
  }
}
