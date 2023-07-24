import 'package:flutter/material.dart';

Widget InputTextNumber(
    BuildContext context,
    String labelhint,
    bool obscureText,
    IconData icon,
    TextInputType ktype,
    TextEditingController controller,
    String? errortext,
    bool validate) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.71,
    height: MediaQuery.of(context).size.height * 0.08,
    child: TextFormField(
      controller: controller,
      keyboardType: ktype,
      obscureText: false,
      style: const TextStyle(
        fontSize: 17,
        color: Colors.grey,
      ),
      decoration: InputDecoration(
        errorText: validate ? null : errortext,
        labelText: labelhint,
        labelStyle: const TextStyle(
          fontSize: 17,
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF006837),
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
  );
}

Widget InputText(
    BuildContext context,
    String hint,
    String labelhint,
    bool obscureText,
    IconData icon,
    TextInputType ktype,
    TextEditingController controller) {
  bool isPasswordVisible = false;
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.71,
    height: MediaQuery.of(context).size.height * 0.08,
    child: TextFormField(
      controller: controller,
      keyboardType: ktype,
      obscureText: isPasswordVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Can't be Empity.";
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 17,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: labelhint,
        hintText: hint,
        labelStyle: const TextStyle(
          fontSize: 17,
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF006837),
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
          ),
        ),
      ),
    ),
  );
}

// InputTextFarmSize
Widget InputTextFarmSize(BuildContext context, String hint, String labelhint,
    TextInputType ktype, TextEditingController controller) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.4,
    height: MediaQuery.of(context).size.height * 0.08,
    child: TextFormField(
      controller: controller,
      keyboardType: ktype,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Can't be Empity.";
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 17,
        color: Colors.grey,
      ),
      decoration: InputDecoration(
        labelText: labelhint,
        hintText: hint,
        suffixText: "Sq.",
        labelStyle: const TextStyle(
          fontSize: 17,
          color: Colors.grey,
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
          ),
        ),
      ),
    ),
  );
}

//
Widget InputTextSoilType(BuildContext context, String hint, String labelhint,
    TextInputType ktype, TextEditingController controller) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.71,
    height: MediaQuery.of(context).size.height * 0.08,
    child: TextFormField(
      controller: controller,
      keyboardType: ktype,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Can't be Empity.";
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 17,
        color: Colors.grey,
      ),
      decoration: InputDecoration(
        labelText: labelhint,
        hintText: hint,
        // suffixText: "Sq.",
        labelStyle: const TextStyle(
          fontSize: 17,
          color: Colors.grey,
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
          ),
        ),
      ),
    ),
  );
}

Widget InputTextFarmLocation(
    BuildContext context,
    String hint,
    String labelhint,
    bool obscureText,
    IconData icon,
    TextInputType ktype,
    TextEditingController controller) {
  bool isPasswordVisible = false;
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.5,
    height: MediaQuery.of(context).size.height * 0.08,
    child: TextFormField(
      controller: controller,
      keyboardType: ktype,
      obscureText: isPasswordVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Can't be Empity.";
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 17,
        color: Colors.grey,
      ),
      decoration: InputDecoration(
        labelText: labelhint,
        hintText: hint,
        labelStyle: const TextStyle(
          fontSize: 17,
          color: Colors.grey,
        ),
        suffixIcon: Icon(
          icon,
          color: Theme.of(context).primaryColor,
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
          ),
        ),
      ),
    ),
  );
}
