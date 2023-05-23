import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:armada/view/widgets/widgets.dart';
import 'package:flutter/services.dart';

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
  final TextEditingController _Numbercontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _userNamecontroller = TextEditingController();
  final TextEditingController _confirmPasswordcontroller =
      TextEditingController();

  bool value = false;
  bool isHidden = true;
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
                InputTextNumber(context, "Phone", false, Icons.phone_sharp,
                    TextInputType.phone, _Numbercontroller),
                addVerticalSpace(31.0),
                // InputTextPassword(
                //     context,
                //     "Password",
                //     isHidden,
                //     Icons.lock_sharp,
                //     TextInputType.text,
                //     _passwordcontroller,
                //     _togglePasswordView),

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
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                      // errorText: etext,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.green,
                          )),
                      // border: InputBorder.none,
                      // focusedBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(15),
                      //     borderSide: const BorderSide(
                      //       width: 1,
                      //       color: Colors.green,
                      //     )),
                      // enabledBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(15),
                      //     borderSide: const BorderSide(
                      //       width: 1,
                      //       color: Colors.green,
                      //     )),
                    ),
                  ),
                ),

                // sdfg
                // sdfg
                // sdfg
                // sdfgsdfg
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
                // Button(context, "LogIn", '/', Theme.of(context).primaryColor,
                //     150, 55),
                // LoginButton(context),
                Container(
                    child: InkWell(
                  onTap: () {
                    // Navigator.pushNamed(context, routh);
                    if (formKey.currentState!.validate()) {}
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
                )
                    // width: MediaQuery.of(context).size.width - 150,
                    // child: ElevatedButton(
                    //   onPressed: () {
                    //     if (formKey.currentState!.validate()) {}
                    //   },
                    //   style: ButtonStyle(),
                    //   child: Container(
                    //     height: 55,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       color: Theme.of(context).primaryColor,
                    //     ),
                    //     child: const Center(
                    //       child: Text(
                    //         "login",
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 20,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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

  void _togglePasswordView() {
    setState(() {
      isHidden = !isHidden;
    });
  }
}

// Widget LoginButton(
//   BuildContext context,
// ) {
//   return ElevatedButton(
//     onPressed: () {
//       if (formKey.currentState!.validate()) {}
//     },
//     child: Container(
//       width: MediaQuery.of(context).size.width - 150,
//       height: 55,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: Theme.of(context).primaryColor,
//       ),
//       child: const Center(
//         child: Text(
//           "login",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//           ),
//         ),
//       ),
//     ),
//   );
// }
