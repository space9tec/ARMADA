import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:armada/networkhandler.dart';
import '../../../utils/helper_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UploadFarm extends StatefulWidget {
  static const String routeName = '/upload_farm';

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
  final TextEditingController _farmName = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _croptype = TextEditingController();
  final TextEditingController _soiltype = TextEditingController();
  final TextEditingController _polygonlocation = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  final storage = const FlutterSecureStorage();

  bool validate = false;
  String? errorText;

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  final image = Image.asset(
    // fit: BoxFit.scaleDown,
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
                            InputTextFarmLocation(
                                context,
                                "Location.",
                                "Location",
                                false,
                                Icons.person_3_sharp,
                                TextInputType.number,
                                _location),
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
                    InputText(context, "", "Crop type", false,
                        Icons.person_3_sharp, TextInputType.name, _croptype),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputTextFarmSize(context, "", "Soil type",
                                TextInputType.text, _soiltype),
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
                                "Typ",
                                false,
                                Icons.person_3_sharp,
                                TextInputType.number,
                                _polygonlocation),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    String? userid = await storage.read(key: "userid");
                    print(userid);

                    if (formKey.currentState!.validate()) {
                      Map<String, String> data = {
                        "farm_size": _farmSize.text,
                        "farm_name": _farmName.text,
                        "latitude": _location.text,
                        "crops_grown": _croptype.text,
                        "soil_type": _soiltype.text,
                        "longitude": _polygonlocation.text,
                        "owner_id": userid!,
                      };
                      print(data);

                      var response = await networkHandler.post(
                          "/api/farm/", data, "farmData",
                          imageFile: imageFile!);

                      if (response.statusCode == 201) {
                        Navigator.pushNamed(context, '/farm_screen');
                      } else {
                        // String output = json.decode(response.toString());
                        print(response.body.toString());
                        setState(() {
                          validate = false;
                          // errorText = output;
                        });
                      }
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
      onTap: () {},
      child: DottedBorder(
        dashPattern: const [15, 5],
        color: const Color.fromARGB(255, 48, 141, 51),
        strokeWidth: 2,
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.17, //141
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
        ),
      ),
    );
  }
}
