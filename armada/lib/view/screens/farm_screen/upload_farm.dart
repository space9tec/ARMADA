import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../utils/helper_widget.dart';
import '../../widgets/widgets.dart';

class UploadFarm extends StatefulWidget {
  static const String routeName = '/upload_farm';

// till line 19 route code
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return UploadFarm();
      },
    );
  }

  UploadFarm({Key? key}) : super(key: key);

  @override
  State<UploadFarm> createState() => _UploadFarmState();
}

class _UploadFarmState extends State<UploadFarm> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _farmSize = TextEditingController();
  final TextEditingController _userNamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/display_notification');
            },
            icon: const Icon(Icons.notifications_sharp),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
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
                      "Farm Information.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InputText(
                        context,
                        "Full name",
                        "Farm Name",
                        false,
                        Icons.person_3_sharp,
                        TextInputType.name,
                        _userNamecontroller),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputTextFarmSize(
                                context,
                                "",
                                "Farm Size",
                                false,
                                Icons.person_3_sharp,
                                TextInputType.number,
                                _farmSize),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputTextFarmLocation(
                                context,
                                "Location.",
                                "Location",
                                false,
                                Icons.person_3_sharp,
                                TextInputType.text,
                                _farmSize),
                          ],
                        ),
                      ],
                    ),
                    addVerticalSpace(20.0),
                    Text(
                      "Optional Information.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InputText(
                        context,
                        "",
                        "Crop type",
                        false,
                        Icons.person_3_sharp,
                        TextInputType.name,
                        _userNamecontroller),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputTextFarmSize(
                                context,
                                "",
                                "Soil type",
                                false,
                                Icons.person_3_sharp,
                                TextInputType.number,
                                _farmSize),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputTextFarmLocation(
                                context,
                                "",
                                "Type",
                                false,
                                Icons.person_3_sharp,
                                TextInputType.text,
                                _farmSize),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    // Navigator.pushNamed(context, routh);
                    if (formKey.currentState!.validate()) {
                      Map<String, String> data = {
                        "farm_size": _farmSize.text,
                      };
                      print(data);
                      Navigator.pushNamed(context, '/verify');
                    }
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
                        "Post",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addCoverPhoto() {
    return InkWell(
      onTap: () {
        // add image to mongo
      },
      // This is ana external package
      child: DottedBorder(
          dashPattern: [15, 5],
          color: Color.fromARGB(255, 48, 141, 51),
          strokeWidth: 2,
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          child: SizedBox(
            width: double.infinity,
            height: 141,
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
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 48, 141, 51)),
                  ),
                  Text(
                    "Up to 12mp ",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
