import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const Center(
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 28.0,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              InputText(context, "Phone", false, Icons.phone_sharp),
              const SizedBox(
                height: 6.0,
              ),
              InputText(context, "Password", true, Icons.lock_sharp),
              const SizedBox(
                height: 35.0,
              ),
              Center(child: Button(context, "LogIn")),
              const SizedBox(
                height: 24.0,
              ),
              const Center(child: Text("Don't have an account?")),
              const SizedBox(
                height: 12.0,
              ),
              Center(
                child: Text(
                  "Create an account",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Button(BuildContext context, String login) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 8, 204, 113),
              Color.fromARGB(255, 10, 190, 106),
              Color.fromARGB(255, 17, 156, 91),
            ],
          ),
        ),
        child: Center(
          child: Text(
            login,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

Widget InputText(
    BuildContext context, String hint, bool obscureText, IconData icon) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 70,
    height: 55,
    child: TextFormField(
      obscureText: obscureText,
      style: const TextStyle(
        fontSize: 17,
        color: Colors.grey,
      ),
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: const TextStyle(
          fontSize: 17,
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          icon,
          color: const Color.fromARGB(255, 10, 190, 106),
        ),
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
  );
}
