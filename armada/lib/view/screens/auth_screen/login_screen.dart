import 'dart:convert';
import 'package:armada/provider/drop_down_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:armada/view/widgets/widgets.dart';
import 'package:armada/networkhandler.dart';
import 'package:provider/provider.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../../models/user.dart';
import '../../../provider/user_provider.dart';
import '../../../provider/usermodel_provider.dart';

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
                  height: 140,
                  width: 140,
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
                addVerticalSpace(MediaQuery.of(context).size.width * 0.1),
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
                  width: MediaQuery.of(context).size.width * 0.72,
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
                            ? Icon(Icons.visibility_off, color: Colors.grey)
                            : Icon(Icons.visibility, color: Color(0xFF006837)),
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
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(MediaQuery.of(context).size.width * 0.12),
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
                        print(data);

                        try {
                          var response = await networkHandler.postt(
                              "/api/auth/login", data);
                          if (response.statusCode == 200) {
                            Map<String, dynamic> output =
                                json.decode(response.body);

                            print("yes");
                            Provider.of<UserProvider>(context, listen: false)
                                .setUser(
                                    output['user_id']!, output['user_id']!);
                            await storage.write(
                                key: 'token', value: output['Token']);
                            print(output);
                            String? tok = await storage.read(key: "token");
                            print(tok);
                            // String? tok = await storage.read(key: "userid");

                            await storage.write(
                                key: 'userid', value: output['user_id']);

                            // String? userrole=await storage.write(
                            //     key: 'userrole', value: );
                            Provider.of<DropDownProvider>(context,
                                    listen: false)
                                .setAccountType(output['role']);
                            String? userid = await storage.read(key: "userid");
                            print(userid);

                            UserMProvider userProvider =
                                Provider.of<UserMProvider>(context,
                                    listen: false);

                            // Set the user ID in the provider
                            userProvider.setUserModel(output['user_id']);
                            // USER MODEL PROVIDER
                            // final userProvider = Provider.of<UserMProvider>(
                            //     context,
                            //     listen: false);
                            // // create the user model instance using the response data
                            // final userModel = User.fromJson(output['user_id']);
                            // // store the user model instance in the UserProvider
                            // userProvider.setUserModel(userModel);
                            // user model provider

                            //TOAST
                            BotToast.showText(
                              text: "Welcome! You have successfully logged in.",
                              duration: Duration(seconds: 2),
                              contentColor: Colors.white,
                              textStyle: TextStyle(
                                  fontSize: 16.0, color: Color(0xFF006837)),
                            );
                            //toast end
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/', (Route<dynamic> route) => false);
                          } else {
                            BotToast.showText(
                              text: "Failed to login: ${response.statusCode}",
                              duration: Duration(seconds: 2),
                              contentColor: Colors.white,
                              textStyle: TextStyle(
                                  fontSize: 16.0, color: Color(0xFF006837)),
                            );
                            throw Exception(
                                'Failed to login: ${response.statusCode}');
                          }
                        } catch (e) {
                          BotToast.showText(
                            text: "Failed to login: ${e}",
                            duration: Duration(seconds: 2),
                            contentColor: Colors.white,
                            textStyle: TextStyle(
                                fontSize: 16.0, color: Color(0xFF006837)),
                          );
                          print("dont work:${e}");
                        }
                        print("data");
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.63,
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
