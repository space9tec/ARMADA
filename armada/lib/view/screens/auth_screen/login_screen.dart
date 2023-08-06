import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../models/usermodel.dart';
import '../../../networkhandler.dart';
import '../../../services/tokenManager.dart';
import '../../../utils/helper_widget.dart';

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
  NetworkHandler networkHandler = NetworkHandler();
  final formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();

  final TextEditingController _numbercontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  late UserModel usermode;

  bool value = false;
  bool isHidden = true;
  bool validate = true;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addVerticalSpace(MediaQuery.of(context).size.width * 0.19),
                Center(
                  child: Text("Welcome.",
                      style: Theme.of(context).textTheme.displayLarge),
                ),
                addVerticalSpace(MediaQuery.of(context).size.width * 0.06),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Image.asset("assets/images/logo.jpeg"),
                ),
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
                addVerticalSpace(MediaQuery.of(context).size.height * 0.05),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.71,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: TextFormField(
                    controller: _numbercontroller,
                    keyboardType: TextInputType.phone,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.length != 13) {
                        return "Phone must be 13 digit.";
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                    ),
                    decoration: InputDecoration(
                      labelText: "Phone",
                      labelStyle: const TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                      prefixIcon: const Icon(
                        Icons.phone_sharp,
                        color: Color(0xFF006837),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xFF006837),
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
                addVerticalSpace(MediaQuery.of(context).size.height * 0.01),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.71,
                  height: MediaQuery.of(context).size.height * 0.1,
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
                            ? const Icon(Icons.visibility_off,
                                color: Colors.grey)
                            : const Icon(Icons.visibility,
                                color: Color(0xFF006837)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xFF006837),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xFF006837),
                        ),
                      ),
                    ),
                  ),
                ),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/forgetpassword');
                        },
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(MediaQuery.of(context).size.width * 0.12),
                InkWell(
                  onTap: () async {
                    checkUser();

                    if (formKey.currentState!.validate() && validate) {
                      EasyLoading.show(status: 'loading...');

                      Map<String, String> data = {
                        "phone": _numbercontroller.text,
                        "password": _passwordcontroller.text,
                      };
                      print(data);

                      try {
                        var response =
                            await networkHandler.postt("/api/auth/login", data);
                        if (response.statusCode == 200) {
                          Map<String, dynamic> output =
                              json.decode(response.body);

                          // set token
                          await TokenManager().setToken(output['Token']);

                          // set usermodel
                          Map<String, dynamic> userData = output['user'];

                          // Create UserModel instance using the user data
                          UserModel user = UserModel.fromJson(userData);
                          // UserModel user = UserModel.fromJson(output);

                          // Convert UserModel to JSON
                          String userJson = json.encode(user.toJson());

                          // Store the JSON representation of UserModel securely

                          await storage.write(key: 'userm', value: userJson);

                          //TOAST
                          EasyLoading.dismiss();

                          BotToast.showText(
                            text: "You have successfully logged in.",
                            duration: const Duration(seconds: 2),
                            contentColor: Color.fromARGB(255, 201, 194, 194),
                            textStyle: const TextStyle(
                                fontSize: 16.0, color: Color(0xFF006837)),
                          );
                          //toast end
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/home', (Route<dynamic> route) => false);
                        } else {
                          BotToast.showText(
                            text: "Failed to login",
                            duration: const Duration(seconds: 2),
                            contentColor: Colors.white,
                            textStyle: const TextStyle(
                                fontSize: 16.0, color: Color(0xFF006837)),
                          );
                          throw Exception('Failed to : ${response.statusCode}');
                        }
                      } catch (e) {
                        BotToast.showText(
                          text: "Failed to logi: $e",
                          duration: const Duration(seconds: 2),
                          contentColor: Colors.white,
                          textStyle: const TextStyle(
                              fontSize: 16.0, color: Color(0xFF006837)),
                        );
                      }
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: const Center(
                      child: Text(
                        "login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
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
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkUser() {
    if (_numbercontroller.text.isEmpty) {
      setState(() {
        validate = false;
        errorText = "Phone can't be empty";
      });
    } else if (_numbercontroller.text.length != 13) {
      setState(() {
        validate = false;
        errorText = "Phone must be 13 digit.";
      });
    }
  }

  void _togglePasswordView() {
    setState(() {
      isHidden = !isHidden;
    });
  }
}
