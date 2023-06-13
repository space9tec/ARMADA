import 'dart:convert';
// import 'dart:html';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:armada/view/widgets/widgets.dart';
import 'package:armada/networkhandler.dart';
// import 'package:http/http.dart' as http;

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
  final formKey = GlobalKey<FormState>();
  final TextEditingController _numbercontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  bool value = false;
  bool isHidden = true;

  NetworkHandler networkHandler = NetworkHandler();
  final storage = new FlutterSecureStorage();
  // Map<String, String> storageone =
  //     new FlutterSecureStorage() as Map<String, String>;

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
                InputTextNumber(
                    context,
                    "Phone",
                    false,
                    Icons.phone_sharp,
                    TextInputType.phone,
                    _numbercontroller,
                    errorText,
                    validate),
                addVerticalSpace(31.0),
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
                            ? Icon(Icons.visibility_off, color: Colors.grey)
                            : Icon(Icons.visibility, color: Colors.green),
                      ),
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
                          color: Colors.green,
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
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(60.0),
                Container(
                  child: InkWell(
                    onTap: () async {
                      checkUser();
                      print("object");
                      if (formKey.currentState!.validate() && validate) {
                        Map<String, String> data = {
                          "phone": _numbercontroller.text,
                          "password": _passwordcontroller.text,
                        };
// +251977389783
                        print(data);

                        try {
                          var response = await networkHandler.post(
                              "/api/auth/login", data);
                          if (response.statusCode == 200) {
                            Map<String, dynamic> output =
                                json.decode(response.body);
                            // String jsonString = json.encode(output);
                            print("yes");
                            // print("Token: $output['Token']");
                            await storage.write(
                                key: 'token', value: output['Token']);

                            String? tok = await storage.read(key: "token");
                            print(tok);

                            await storage.write(
                                key: 'userid', value: output['user_id']);

                            String? userid = await storage.read(key: "userid");
                            print(userid);

                            // await storage.write(key: 'user', value: jsonString);
//                             String storedJsonString = await storage.read(key: 'userData');
// Map<String, dynamic> storedData = json.decode(storedJsonString);
                            // String? storedJsonString =
                            //     await storage.read(key: 'user');
                            // Map<String, dynamic> storedData =
                            //     json.decode(storedJsonString!);

                            // print("Hello: $storedData['_id']");
                            // String? user = await storage.read(key: "user");
                            // print(user);

                            // await storage.write(
                            //     key: 'user', value: output['user']);

                            // Map<String, String>? user = (await storage.read(
                            //     key: "user")) as Map<String, String>?;
                            // print("hello: $user");
                            // setState(() {
                            //   validate = true;
                            // });
                            // Navigator.pushAndRemoveUntil(
                            //     context, '/', (route) => false);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/', (Route<dynamic> route) => false);
                            // Navigator.pushAndRemoveUntil(context,
                            //     '/' as Route<Object?>, (route) => false);
                          } else if (response.statusCode == 408) {
                            print("408");
                          } else if (response.statusCode == 500) {
                            // handle server error
                            print("500");
                          } else {
                            throw Exception(
                                'Failed to login: ${response.statusCode}');
                          }
                        } catch (e) {
                          print("dont work:${e}");
                        }
                        //else {
                        //   print("dontwork");
                        //   String output = json.decode(response.body);
                        //   setState(() {
                        //     validate = false;
                        //     errorText = output;
                        //   });
                        // }
                        print("data");
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
                          "login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
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
                    style: Theme.of(context).textTheme.displaySmall,
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
