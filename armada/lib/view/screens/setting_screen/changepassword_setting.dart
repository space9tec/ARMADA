import 'package:flutter/material.dart';

import '../../../utils/helper_widget.dart';

class ChangePassword extends StatefulWidget {
  static const String routeName = '/changepassword';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ChangePassword(),
    );
  }

  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text("Change Password"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                    color: Color(0xFF006837),
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
                            color: Color(0xFF006837),
                          ),
                  ),
                  // errorText: etext,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.green,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF006837),
                      )),
                ),
              ),
            ),
            addVerticalSpace(MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.70,
              height: MediaQuery.of(context).size.height * 0.075,
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
                    color: Color(0xFF006837),
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
                            color: Color(0xFF006837),
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
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF006837),
                      )),
                ),
              ),
            ),
            addVerticalSpace(MediaQuery.of(context).size.height * 0.03),
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
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Center(
                    child: Text(
                      "Change",
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
