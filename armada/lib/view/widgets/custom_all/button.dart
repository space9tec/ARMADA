import 'package:flutter/material.dart';

Widget Button(BuildContext context, String login, String routh, Color colors,
    double width, double height) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, routh);
    },
    child: Container(
      width: MediaQuery.of(context).size.width - width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: colors,
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
