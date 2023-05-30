import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../screens/screens.dart';
import 'widgets.dart';

class UploadTap extends StatefulWidget {
  static const String routeName = '/add_farm1';

// till line 19 route code
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return UploadTap();
      },
    );
  }

  UploadTap({Key? key}) : super(key: key);

  @override
  State<UploadTap> createState() => _UploadTapState();
}

class _UploadTapState extends State<UploadTap> {
  final TextEditingController _Numbercontroller = TextEditingController();

  final TextEditingController _Emailcontroller = TextEditingController();

  final TextEditingController _passwordcontroller = TextEditingController();

  final TextEditingController _userNamecontroller = TextEditingController();

  final TextEditingController _confirmPasswordcontroller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Text(
                        "1/2",
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addCoverPhoto(),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Food Name",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputText(
                          context,
                          "Full name",
                          "abebe",
                          false,
                          Icons.person_3_sharp,
                          TextInputType.name,
                          _userNamecontroller),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputText(
                          context,
                          "Full name",
                          "abebe",
                          false,
                          Icons.person_3_sharp,
                          TextInputType.name,
                          _userNamecontroller),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddFarm()));
                          },
                          text: "Next")
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  addCoverPhoto() {
    return InkWell(
      onTap: () {
        // add image to firbase
      },
      // This is ana external package
      child: DottedBorder(
          dashPattern: [15, 5],
          color: Colors.black,
          strokeWidth: 2,
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          child: SizedBox(
            width: double.infinity,
            height: 160,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(
                    Icons.photo,
                    size: 65,
                    color: Colors.grey,
                  ),
                  Text(
                    "Add Cove Photo",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text("Up to 12mp ")
                ],
              ),
            ),
          )),
    );
  }
}
