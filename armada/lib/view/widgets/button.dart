import 'package:flutter/material.dart';

Widget Button(BuildContext context, String login, String routh) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, routh);
    },
    child: Container(
      width: MediaQuery.of(context).size.width - 150,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 8, 204, 113),
            Color.fromARGB(255, 10, 190, 106),
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
