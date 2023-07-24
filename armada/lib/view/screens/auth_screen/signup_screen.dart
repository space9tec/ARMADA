import 'package:armada/networkhandler.dart';
import 'package:armada/provider/drop_down_provider.dart';
import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:armada/view/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  final formKey = GlobalKey<FormState>();

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _firstNamecontroller = TextEditingController();
  final TextEditingController _lastNamecontroller = TextEditingController();

  final TextEditingController _confirmPasswordcontroller =
      TextEditingController();
  bool value = false;
  bool isHidden = true;
  bool isHiddenConfirm = true;

  final storage = new FlutterSecureStorage();

  NetworkHandler networkHandler = NetworkHandler();
  bool validate = false;
  String? errorText;

  String? _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Please confirm your password.';
    } else if (value != _passwordcontroller.text) {
      return 'Passwords do not match.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addVerticalSpace(MediaQuery.of(context).size.width * 0.12),
                Center(
                  child: Text("Create Account.",
                      style: Theme.of(context).textTheme.displayLarge),
                ),
                addVerticalSpace(MediaQuery.of(context).size.width * 0.20),
                InputText(
                    context,
                    "First Name",
                    "First Name",
                    false,
                    Icons.person_3_sharp,
                    TextInputType.name,
                    _firstNamecontroller),
                addVerticalSpace(15.0),
                InputText(
                    context,
                    "Last Name",
                    "Last Name",
                    false,
                    Icons.person_3_sharp,
                    TextInputType.name,
                    _lastNamecontroller),
                addVerticalSpace(15.0),
                InputTextNumber(
                    context,
                    "Phone",
                    false,
                    Icons.phone_sharp,
                    TextInputType.phone,
                    _numberController,
                    errorText,
                    validate),
                addVerticalSpace(15.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.71,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: TextFormField(
                    controller: _passwordcontroller,
                    keyboardType: TextInputType.text,
                    obscureText: isHidden,
                    // onChanged: (_) {
                    //   _checkPasswordsMatch();
                    // },
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
                addVerticalSpace(15.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.71,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: TextFormField(
                    controller: _confirmPasswordcontroller,
                    keyboardType: TextInputType.text,
                    obscureText: isHiddenConfirm,
                    // onChanged: (_) {
                    //   _checkPasswordsMatch();
                    // },
                    validator: (value) {
                      if (value == null || value.length < 4) {
                        return "More than 4 character needed";
                      } else if (value != _passwordcontroller.text) {
                        return "Password dont match.";
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
                            ? const Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: Color(0xFF006837),
                              ),
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
                addVerticalSpace(15.0),
                // accountSelector(context),
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
                addVerticalSpace(20.0),
                Consumer<DropDownProvider>(
                  builder: (context, value, child) => Container(
                    child: InkWell(
                      onTap: () async {
                        await checkUser();
                        // _selectedAccountType = value.selectedAccount;
                        // if (_passwordsMatch) {
                        if (formKey.currentState!.validate() && validate) {
                          Map<String, String> data = {
                            "first_name": _firstNamecontroller.text,
                            "last_name": _lastNamecontroller.text,
                            "phone": _numberController.text,
                            "password": _passwordcontroller.text,
                            // "role": "Farmer",
                          };
                          var response = await networkHandler.post(
                              "/api/auth/register", data, "userData",
                              imageFile: null);

                          if (response.statusCode == 200 ||
                              response.statusCode == 201) {
                            await storage.write(
                                key: 'phone', value: _numberController.text);
                            Navigator.pushNamed(context, '/verify');
                          } else {
                            print("faild");
                            print(response.body.toString());

                            setState(() {
                              validate = false;
                              // errorText = output;
                            });
                          }
                        }
                        // }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: const Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                addVerticalSpace(24.0),
                Text(
                  "Already have an account.",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                addVerticalSpace(1.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    "Login",
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

  checkUser() async {
    if (_numberController.text.isEmpty) {
      setState(() {
        validate = false;
        errorText = "Phone can't be empty";
      });
    } else if (_numberController.text.length != 13) {
      setState(() {
        validate = false;
        errorText = "Phone must be 10 digit.";
      });
    } else {
      setState(() {
        validate = true;
      });
    }
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
