import 'package:armada/view/widgets/homePageCarouse.dart';
import 'package:email_validator/email_validator.dart';
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
    width: MediaQuery.of(context).size.width - 120,
    height: 67,
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
          color: const Color.fromARGB(255, 10, 190, 106),
        ),
        // suffixIcon: obscureText
        //     ? IconButton(
        //         onPressed: () {
        //           setState(() {
        //             isPasswordVisible = !isPasswordVisible;
        //           });
        //         },
        //         icon: isPasswordVisible
        //             ? Icon(Icons.visibility_off)
        //             : Icon(Icons.visibility),
        //       )
        //     : null,
        // errorText: etext,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.green,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.green,
            )),
        // enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(15),
        //     borderSide: const BorderSide(
        //       width: 1,
        //       color: Colors.green,
        //     )),
      ),
    ),
  );
}

// Scaffold(

// Widget InputTextPassword(
//     BuildContext context,
//     String labelhint,
//     bool obscureTex,
//     IconData icon,
//     TextInputType ktype,
//     TextEditingController controller) {
//   bool isbisible = true;
//   void togglePasswordView() {
//     setState(() {
//       isbisible = !isbisible;
//       print(isbisible);
//     });
//   }

Widget InputTextPassword(
    BuildContext context,
    String labelhint,
    bool obscureTex,
    IconData icon,
    TextInputType ktype,
    TextEditingController controller,
    Function() showiconvisible) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 120,
    height: 67,
    child: TextFormField(
      controller: controller,
      keyboardType: ktype,
      obscureText: obscureTex,
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
        labelText: labelhint,
        labelStyle: const TextStyle(
          fontSize: 17,
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          icon,
          color: const Color.fromARGB(255, 10, 190, 106),
        ),
        suffixIcon: IconButton(
          onPressed: showiconvisible,
          icon:
              obscureTex ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
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
  );
}

Widget InputTextEmail(
    BuildContext context,
    String hint,
    String labelhint,
    bool obscureText,
    IconData icon,
    TextInputType ktype,
    TextEditingController controller) {
  bool isPasswordVisible = false;
  return SizedBox(
    width: MediaQuery.of(context).size.width - 120,
    height: 67,
    child: TextFormField(
      controller: controller,
      keyboardType: ktype,
      obscureText: isPasswordVisible,
      autofillHints: [AutofillHints.email],
      validator: (value) => value != null && !EmailValidator.validate(value)
          ? 'Enter valid Email'
          : null,
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
        prefixIcon: Icon(
          icon,
          color: const Color.fromARGB(255, 10, 190, 106),
        ),
        suffixIcon: obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                icon: isPasswordVisible
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              )
            : null,
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
    width: MediaQuery.of(context).size.width - 120,
    height: 67,
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
          color: const Color.fromARGB(255, 10, 190, 106),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.green,
            )),

        // border: InputBorder.none,ss
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.green,
          ),
        ),
        // enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(15),
        //     borderSide: const BorderSide(
        //       width: 1,
        //       color: Colors.green,
        //     )),
        // errorBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(15),
        //     borderSide: const BorderSide(
        //       width: 1,
        //       color: Colors.redAccent,
        //     )),
      ),
    ),
  );
}

Widget InputTextFarmSize(
    BuildContext context,
    String hint,
    String labelhint,
    bool obscureText,
    IconData icon,
    TextInputType ktype,
    TextEditingController controller) {
  bool isPasswordVisible = false;
  return SizedBox(
    width: MediaQuery.of(context).size.width - 280,
    height: 67,
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
        suffixIcon: Icon(Icons.square_foot),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.green,
            )),
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
    width: MediaQuery.of(context).size.width - 200,
    height: 67,
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
        suffixIcon: Icon(Icons.location_on_sharp),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.green,
            )),
      ),
    ),
  );
}
