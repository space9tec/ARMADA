import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
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
                height: 12,
              ),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              TextFormField(
                controller: phone,
                decoration: const InputDecoration(
                  hintText: "Phone No.",
                  prefixIcon: Icon(
                    Icons.phone_sharp,
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextFormField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(
                    Icons.lock_sharp,
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Login"),
                ),
              ),
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
}
