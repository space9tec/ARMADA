import 'package:flutter/material.dart';

Widget InputText(BuildContext context, String hint, bool obscureText,
    IconData icon, TextInputType ktype) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 120,
    height: 50,
    child: TextFormField(
      keyboardType: ktype,
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
        border: InputBorder.none,
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
