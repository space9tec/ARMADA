import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../models/model.dart';
import '../../../networkhandler.dart';
import '../../../utils/helper_widget.dart';
import '../../widgets/widgets.dart';

class UploadFarm extends StatefulWidget {
  static const String routeName = '/upload_farm';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return const UploadFarm();
      },
    );
  }

  const UploadFarm({Key? key}) : super(key: key);

  @override
  State<UploadFarm> createState() => _UploadFarmState();
}

class _UploadFarmState extends State<UploadFarm> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _farmSize = TextEditingController();
  final TextEditingController _farmName = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  final storage = const FlutterSecureStorage();

  bool validate = false;
  String? errorText;
  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  final _region = [
    'Tigray',
    'Afar',
    "Amhara",
    "Oromia",
    "Somali",
    "SNNPR",
    "Gambela",
    "Benishangul",
    "Harari"
  ];
  String _selectedregion = "Tigray";

  final _soiltype = [
    "Vertisols",
    "Nitosols",
    "Luvisols",
    "Cambisols",
    "Regosols",
    "Leptosols",
    "Gleysols",
    "Other"
  ];
  String _selectedsoiltype = "Vertisols";

  final _cropgrown = [
    "Teff",
    "Wheat",
    "Corn",
    "Barley",
    "Oilseeds",
    "Coffee",
    "Cotton",
    "Sugarcane",
    "Bananas"
  ];
  String _selectedcropgrown = "Teff";

  final image = Image.asset(
    height: 50,
    "assets/images/tracter1.png",
  );
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
                    InputText(context, "Full name", "Farm Name", false,
                        Icons.person_3_sharp, TextInputType.name, _farmName),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputTextFarmSize(context, "", "Farm Size",
                                TextInputType.number, _farmSize),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: DropdownButtonFormField(
                                value: _selectedregion,
                                items: _region
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    _selectedregion = val as String;
                                  });
                                },
                                icon: const Icon(Icons.arrow_drop_down_circle),
                                decoration: InputDecoration(
                                  labelText: "Region",
                                  labelStyle:
                                      const TextStyle(color: Colors.grey),
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
                            )
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
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: DropdownButtonFormField(
                            value: _selectedcropgrown,
                            items: _cropgrown
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _selectedcropgrown = val as String;
                              });
                            },
                            icon: const Icon(Icons.arrow_drop_down_circle),
                            decoration: InputDecoration(
                              labelText: "Crop Grown",
                              labelStyle: TextStyle(color: Colors.grey),
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
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: DropdownButtonFormField(
                            value: _selectedsoiltype,
                            items: _soiltype
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _selectedsoiltype = val as String;
                              });
                            },
                            icon: Icon(Icons.arrow_drop_down_circle),
                            // dropdownColor: Colors.white,
                            decoration: InputDecoration(
                              labelText: "Soil Type",
                              labelStyle: TextStyle(color: Colors.grey),
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
                        ),
                      ],
                    ),
                    // InputText(context, "", "Crop type", false, Icons.grass,
                    //     TextInputType.name, _croptype),

                    const SizedBox(
                      height: 105,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    // DropDownProvider provider =
                    //     Provider.of<DropDownProvider>(context, listen: false);

                    String? userJson = await storage.read(key: 'userm');
                    UserModel usermode =
                        UserModel.fromJson(json.decode(userJson!));

                    if (formKey.currentState!.validate()) {
                      Map<String, String> data = {
                        "farm_size": _farmSize.text,
                        "farm_name": _farmName.text,
                        "region": _selectedregion,
                        "crops_grown": _selectedcropgrown,
                        "soil_type": _selectedsoiltype,
                        "owner_id": usermode.useid,
                      };
                      print(data);

                      var response = await networkHandler.post(
                          "/api/farm/", data, "farmData",
                          imageFile: imageFile);

                      if (response.statusCode == 201) {
                        BotToast.showText(
                          text: "Posted.",
                          duration: Duration(seconds: 2),
                          contentColor: Colors.white,
                          textStyle: TextStyle(
                              fontSize: 16.0, color: Color(0xFF006837)),
                        );
                        Navigator.pushNamed(context, '/farm_screen');
                      } else {
                        print(response.body.toString());
                        setState(() {
                          validate = false;
                          // errorText = output;
                        });
                      }
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: const Center(
                      child: Text(
                        "Add",
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
        showModalBottomSheet(
          context: context,
          builder: ((builder) => bottomSheat()),
        );
      },
      child: DottedBorder(
        dashPattern: const [15, 5],
        color: const Color.fromARGB(255, 48, 141, 51),
        strokeWidth: 2,
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.18, //141
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: imageFile == null
                ? InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheat()),
                      );
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.photo,
                          size: 65,
                          color: Colors.grey,
                        ),
                        Text(
                          "Add Farm Photo",
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
                  )
                : Ink.image(
                    image: imageFile == null
                        ? image.image
                        : FileImage(File(imageFile!.path)),
                    width: 60,
                    height: 60,
                    child: InkWell(onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheat()),
                      );
                    }),
                  ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheat() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(children: [
        const Text(
          "Choose  Farm  Photo",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                takePhote(ImageSource.camera);
              },
              icon: const Icon(Icons.camera),
              label: const Text("Camera"),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor:
                    Theme.of(context).primaryColor, // Change button color here
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                takePhote(ImageSource.gallery);
              },
              icon: const Icon(Icons.image),
              label: const Text("Gallery"),
              style: ElevatedButton.styleFrom(
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(3),
                // ),
                // minimumSize: Size.fromHeight(80),
                elevation: 0,
                backgroundColor:
                    Theme.of(context).primaryColor, // Change button color here
              ),
            )
          ],
        )
      ]),
    );
  }

  void takePhote(ImageSource source) async {
    XFile? pickedFile = await picker.pickImage(source: source);

    setState(() {
      imageFile = pickedFile;
    });
  }
}
