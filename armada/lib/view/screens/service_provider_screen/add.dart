import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:armada/utils/helper_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../../provider/machine_status_provider.dart';
import '../../widgets/widgets.dart';
import 'package:armada/networkhandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../../models/usermodel.dart';

class AddMachine extends StatefulWidget {
  static const String routeName = '/AddMachine';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return const AddMachine();
      },
    );
  }

  const AddMachine({super.key});

  @override
  State<AddMachine> createState() => _AddMachineState();
}

class _AddMachineState extends State<AddMachine> {
  String _currentCarType = '';
  String _currentTractorAttachmentsType = '';

  final TextEditingController _manufacturer = TextEditingController();
  final TextEditingController _model = TextEditingController();
  final TextEditingController _year = TextEditingController();
  final TextEditingController _horsepower = TextEditingController();
  final TextEditingController _hourmeter = TextEditingController();
  final TextEditingController _requiredpower = TextEditingController();
  final TextEditingController _workingcapacity = TextEditingController();
  final TextEditingController _graintank = TextEditingController();
  final TextEditingController _graintypes = TextEditingController();
  final TextEditingController _additionalinformation = TextEditingController();
  final TextEditingController _numberofdiscs = TextEditingController();
  final TextEditingController _numberofrows = TextEditingController();
  final TextEditingController _tankcapacity = TextEditingController();
  final TextEditingController _numberoftires = TextEditingController();
  final TextEditingController _sideboardheight = TextEditingController();
  final TextEditingController _platformdimension = TextEditingController();
  final TextEditingController _loadingcapacity = TextEditingController();
  String? _selectedStatus;

  NetworkHandler networkHandler = NetworkHandler();
  final storage = const FlutterSecureStorage();

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  final _machinestatus = ["Free", "In Maintenance", "Booked"];
  String _selectedmachinestatus = "Free";
  final _regions = [
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

  @override
  void dispose() {
    _loadingcapacity.dispose();
    _platformdimension.dispose();
    _sideboardheight.dispose();
    _numberoftires.dispose();
    _tankcapacity.dispose();
    _numberofrows.dispose();
    _additionalinformation.dispose();
    _graintypes.dispose();
    _graintank.dispose();
    _workingcapacity.dispose();
    _requiredpower.dispose();
    _hourmeter.dispose();
    _horsepower.dispose();
    _year.dispose();
    _model.dispose();
    _manufacturer.dispose();
    super.dispose();
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              addVerticalSpace(5.0),
              const Text('Machinery type:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              addVerticalSpace(20.0),
              // Machinery Type
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.all(0.0),
                          value: 'Tractor',
                          groupValue: _currentCarType,
                          dense: true,
                          selected: _currentCarType == 'Tractor',
                          selectedTileColor: Color.fromARGB(255, 183, 212, 183),
                          activeColor: Theme.of(context).primaryColor,
                          tileColor: Color.fromARGB(255, 234, 240, 234),
                          title: const Text("Tractor",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _currentCarType = value!;
                              _loadingcapacity.clear();
                              _platformdimension.clear();
                              _sideboardheight.clear();
                              _numberoftires.clear();
                              _tankcapacity.clear();
                              _numberofrows.clear();
                              _additionalinformation.clear();
                              _graintypes.clear();
                              _graintank.clear();
                              _workingcapacity.clear();
                              _requiredpower.clear();
                              _hourmeter.clear();
                              _horsepower.clear();
                              _year.clear();
                              _model.clear();
                              _manufacturer.clear();
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.all(0.0),
                          dense: true,
                          selected: _currentCarType == 'Combine Harvester',
                          selectedTileColor: Color.fromARGB(255, 183, 212, 183),
                          activeColor: Theme.of(context).primaryColor,
                          tileColor: Color.fromARGB(255, 234, 240, 234),
                          title: const Text("Combine harvester",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                          value: 'Combine Harvester',
                          groupValue: _currentCarType,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _currentCarType = value!;

                              _loadingcapacity.clear();
                              _platformdimension.clear();
                              _sideboardheight.clear();
                              _numberoftires.clear();
                              _tankcapacity.clear();
                              _numberofrows.clear();
                              _additionalinformation.clear();
                              _graintypes.clear();
                              _graintank.clear();
                              _workingcapacity.clear();
                              _requiredpower.clear();
                              _hourmeter.clear();
                              _horsepower.clear();
                              _year.clear();
                              _model.clear();
                              _manufacturer.clear();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: RadioListTile(
                          contentPadding: EdgeInsets.all(0.0),
                          dense: true,
                          selected: _currentCarType == 'Thresher',
                          selectedTileColor: Color.fromARGB(255, 183, 212, 183),
                          activeColor: Theme.of(context).primaryColor,
                          tileColor: Color.fromARGB(255, 234, 240, 234),
                          title: const Text("Thresher",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          value: 'Thresher',
                          groupValue: _currentCarType,
                          onChanged: (value) {
                            setState(() {
                              _currentCarType = value!;
                              _loadingcapacity.clear();
                              _platformdimension.clear();
                              _sideboardheight.clear();
                              _numberoftires.clear();
                              _tankcapacity.clear();
                              _numberofrows.clear();
                              _additionalinformation.clear();
                              _graintypes.clear();
                              _graintank.clear();
                              _workingcapacity.clear();
                              _requiredpower.clear();
                              _hourmeter.clear();
                              _horsepower.clear();
                              _year.clear();
                              _model.clear();
                              _manufacturer.clear();
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.all(0.0),
                          dense: true,
                          selected: _currentCarType == 'Tractor Attachment',
                          selectedTileColor: Color.fromARGB(255, 183, 212, 183),
                          activeColor: Theme.of(context).primaryColor,
                          tileColor: Color.fromARGB(255, 234, 240, 234),
                          title: const Text("Tractor Attachment",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          value: 'Tractor Attachment',
                          groupValue: _currentCarType,
                          onChanged: (value) {
                            setState(() {
                              _currentCarType = value!;
                              _loadingcapacity.clear();
                              _platformdimension.clear();
                              _sideboardheight.clear();
                              _numberoftires.clear();
                              _tankcapacity.clear();
                              _numberofrows.clear();
                              _additionalinformation.clear();
                              _graintypes.clear();
                              _graintank.clear();
                              _workingcapacity.clear();
                              _requiredpower.clear();
                              _hourmeter.clear();
                              _horsepower.clear();
                              _year.clear();
                              _model.clear();
                              _manufacturer.clear();
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: RadioListTile(
                          contentPadding: EdgeInsets.all(0.0),
                          dense: true,
                          selected: _currentCarType == 'Other',
                          selectedTileColor: Color.fromARGB(255, 183, 212, 183),
                          activeColor: Theme.of(context).primaryColor,
                          tileColor: Color.fromARGB(255, 234, 240, 234),
                          title: const Text("Other",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          value: 'Other',
                          groupValue: _currentCarType,
                          onChanged: (value) {
                            setState(() {
                              _currentCarType = value!;
                              _loadingcapacity.clear();
                              _platformdimension.clear();
                              _sideboardheight.clear();
                              _numberoftires.clear();
                              _tankcapacity.clear();
                              _numberofrows.clear();
                              _additionalinformation.clear();
                              _graintypes.clear();
                              _graintank.clear();
                              _workingcapacity.clear();
                              _requiredpower.clear();
                              _hourmeter.clear();
                              _horsepower.clear();
                              _year.clear();
                              _model.clear();
                              _manufacturer.clear();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              addVerticalSpace(20.0),

              if (_currentCarType == 'Tractor')
                _buildTractorInputs(_currentCarType),
              if (_currentCarType == 'Combine Harvester')
                _buildTractorInputs(_currentCarType),
              if (_currentCarType == 'Thresher')
                _buildTractorInputs(_currentCarType),
              if (_currentCarType == 'Tractor Attachment')
                _buildTractorAttachmentsInputs(),
              if (_currentCarType == 'Other')
                _buildTractorInputs(_currentCarType),
              if (_currentCarType == 'Tractor Attachment')
                if (_currentTractorAttachmentsType == 'Disc Plough')
                  _buildSedanInputs(_currentTractorAttachmentsType),
              if (_currentCarType == 'Tractor Attachment')
                if (_currentTractorAttachmentsType == 'Disc Harrow')
                  _buildSedanInputs(_currentTractorAttachmentsType),
              if (_currentCarType == 'Tractor Attachment')
                if (_currentTractorAttachmentsType == 'Planter')
                  _buildSedanInputs(_currentTractorAttachmentsType),
              if (_currentCarType == 'Tractor Attachment')
                if (_currentTractorAttachmentsType == 'Sprayer')
                  _buildSedanInputs(_currentTractorAttachmentsType),
              if (_currentCarType == 'Tractor Attachment')
                if (_currentTractorAttachmentsType == 'Baler')
                  _buildSedanInputs(_currentTractorAttachmentsType),
              if (_currentCarType == 'Tractor Attachment')
                if (_currentTractorAttachmentsType == 'Trailer')
                  _buildSedanInputs(_currentTractorAttachmentsType),
              if (_currentCarType == 'Tractor Attachment')
                if (_currentTractorAttachmentsType == 'Other')
                  _buildSedanInputs(_currentTractorAttachmentsType),
              addVerticalSpace(50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTractorInputs(String machintype) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // manufacturer
          newmachineInput(
              context: context,
              icon: Icons.person,
              keybordtype: TextInputType.name,
              labletext: "manufacturer",
              manufacturer: _manufacturer,
              widthl: 0.65),
          SizedBox(height: 5),
          // model
          Row(children: [
            newmachineInput(
                context: context,
                icon: Icons.model_training,
                keybordtype: TextInputType.name,
                labletext: "Model",
                manufacturer: _model,
                widthl: 0.5),
            SizedBox(width: 10),
            newmachineInput(
                context: context,
                icon: Icons.calendar_month_outlined,
                keybordtype: TextInputType.datetime,
                labletext: "Year",
                manufacturer: _year,
                widthl: 0.4),
          ]),

          SizedBox(height: 5),

          if (machintype == "Tractor") tractor(),
          if (machintype == "Combine Harvester") Combineharvester(),
          if (machintype == "Thresher") Thresher(),
          if (machintype == "Other") Other(),
          SizedBox(height: 10),

          // Region
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: DropdownButtonFormField(
                  value: _selectedregion,
                  items: _regions
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedregion = val as String;
                    });
                  },
                  icon: Icon(Icons.arrow_drop_down_circle),
                  dropdownColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Region",
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
              SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: DropdownButtonFormField(
                  value: _selectedmachinestatus,
                  items: _machinestatus
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedmachinestatus = val as String;
                    });
                  },
                  icon: Icon(Icons.arrow_drop_down_circle),
                  dropdownColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Status",
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
          addVerticalSpace(10),
          // Machine Image
          Row(
            children: [
              SizedBox(
                // width: MediaQuery.of(context).size.width - 322,
                child: Text(
                  "Select  Image",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              addHorizontalSpace(40),
              Stack(
                children: [
                  buildImage(),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: buildEditIcon(context, Colors.green),
                  ),
                ],
              ),
            ],
          ),
          addVerticalSpace(15),
          // Add machine request
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<MachineStatusProvider>(
                builder: (context, value, child) => ElevatedButton(
                  onPressed: () async {
                    String? userJson = await storage.read(key: 'userm');
                    UserModel usermode =
                        UserModel.fromJson(json.decode(userJson!));

                    if (_formKey.currentState!.validate()) {
                      // if (machintype == "Tractor") {
                      Map<String, String> data = {
                        "model": _model.text,
                        "manufacturer": _manufacturer.text,
                        "type": _currentCarType,
                        "owner_id": usermode.useid,
                        "status": _selectedmachinestatus,
                        "year": _year.text,
                        "region": _selectedregion,
                        "hour_meter": _hourmeter.text,
                        "horsepower": _horsepower.text,
                        "grain_tank_capacity": _graintank.text,
                        "grain_types": _graintypes.text,
                        "working_capacity": _workingcapacity.text,
                        "required_power": _requiredpower.text,
                        "additional_info": _additionalinformation.text,
                      };

                      var response = await networkHandler.post(
                          "/api/machinery/", data, "machineData",
                          imageFile: imageFile);

                      if (response.statusCode == 201) {
                        print("Posted");
                        BotToast.showText(
                          text: "successfully Posted.",
                          duration: Duration(seconds: 2),
                          contentColor: Colors.white,
                          textStyle: TextStyle(
                              fontSize: 16.0, color: Color(0xFF006837)),
                        );
                        Navigator.pushNamed(context, '/machie_screen');
                      } else {
                        print("faild");
                        print(response.body.toString());
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildEditIcon(context, Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: InkWell(
            onTap: () {
              // Navigator.pushNamed(context, '/edit_farmer_profile');

              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheat()),
              );
            },
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );

  Widget bottomSheat() {
    return Container(
      height: 100,
      width: 300,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(children: [
        const Text(
          "Choose Machinery Photo",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Theme.of(context).primaryColor),
              onPressed: () {
                takePhote(ImageSource.camera);
              },
              icon: Icon(Icons.camera),
              label: Text("Camera"),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Theme.of(context).primaryColor),
              onPressed: () {
                takePhote(ImageSource.gallery);
              },
              icon: Icon(Icons.image),
              label: Text("Gallery"),
            )
          ],
        )
      ]),
    );
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  Widget buildImage() {
    // final image = NetworkImage(widget.imagePath);
    final image = Image.asset(
      fit: BoxFit.scaleDown,
      height: 70,
      "assets/images/tracter1.png",
    );

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: imageFile == null
              ? image.image
              : FileImage(File(imageFile!.path)),
          fit: BoxFit.cover,
          width: 108,
          height: 108,
          child: InkWell(
            onTap: () {},
          ),
        ),
      ),
    );
  }

  void takePhote(ImageSource source) async {
    XFile? pickedFile = await picker.pickImage(source: source);

    setState(() {
      imageFile = pickedFile;
    });
  }

  tractor() {
    return Container(
      child: Column(
        children: [
          Row(children: [
            newmachineInput(
                context: context,
                icon: Icons.power_input,
                keybordtype: TextInputType.datetime,
                labletext: "Horsepower",
                manufacturer: _horsepower,
                widthl: 0.6),
          ]),
          SizedBox(height: 10),
          Row(
            children: [
              newmachineInput(
                  context: context,
                  icon: Icons.format_line_spacing_outlined,
                  keybordtype: TextInputType.datetime,
                  labletext: "Hour meter",
                  manufacturer: _hourmeter,
                  widthl: 0.6),
            ],
          ),
        ],
      ),
    );
  }

  Combineharvester() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 5),
          Row(children: [
            newmachineInput(
                context: context,
                icon: Icons.person,
                keybordtype: TextInputType.number,
                labletext: "Grain Tank Capacity",
                manufacturer: _graintank,
                widthl: 0.5),
            SizedBox(width: 10),
            newmachineInput(
                context: context,
                icon: Icons.person,
                keybordtype: TextInputType.number,
                labletext: "Grain Types",
                manufacturer: _graintypes,
                widthl: 0.4),
          ]),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Thresher() {
    return Container(
      child: Column(
        children: [
          newmachineInput(
              context: context,
              icon: Icons.power_input,
              keybordtype: TextInputType.number,
              labletext: "Required power (hp)",
              manufacturer: _requiredpower,
              widthl: 0.75),
          SizedBox(height: 10),
          newmachineInput(
              context: context,
              icon: Icons.power_input,
              keybordtype: TextInputType.number,
              labletext: "Working Capacity (kg/hr)",
              manufacturer: _workingcapacity,
              widthl: 0.75),
        ],
      ),
    );
  }

  Other() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 5),
          newmachineInput(
              context: context,
              icon: Icons.power_input,
              keybordtype: TextInputType.number,
              labletext: "Additional Information",
              manufacturer: _additionalinformation,
              widthl: 0.75),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildSedanInputs(String attachmenttype) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _manufacturer,
            decoration: InputDecoration(labelText: 'Manufacturer'),
            validator: (value) {
              if (value == null) {
                return "Field can not be Empity";
              }
              return null;
            },
            onSaved: (value) {},
          ),
          TextFormField(
            controller: _model,
            decoration: InputDecoration(labelText: 'Model'),
            validator: (value) {
              if (value == null) {
                return "Field can not be Empity";
              }
              return null;
            },
            onSaved: (value) {},
          ),
          if (attachmenttype == "Disc Plough")
            TextFormField(
              controller: _numberofdiscs,
              decoration: InputDecoration(labelText: 'Number of Discs'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null) {
                  return "Field can not be Empity";
                }
                return null;
              },
              onSaved: (value) {},
            ),
          if (attachmenttype == "Disc Harrow")
            TextFormField(
              controller: _numberofdiscs,
              decoration: InputDecoration(labelText: 'Number of Discs'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null) {
                  return "Field can not be Empity";
                }
                return null;
              },
              onSaved: (value) {},
            ),
          if (attachmenttype == "Planter")
            TextFormField(
              controller: _numberofrows,
              decoration: InputDecoration(labelText: 'Number of Rows'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null) {
                  return "Field can not be Empity";
                }
                return null;
              },
              onSaved: (value) {},
            ),
          if (attachmenttype == "Sprayer")
            TextFormField(
              controller: _tankcapacity,
              decoration: InputDecoration(labelText: 'Tank Capacity'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null) {
                  return "Field can not be Empity";
                }
                return null;
              },
              onSaved: (value) {},
            ),
          if (attachmenttype == "Baler")
            TextFormField(
              controller: _requiredpower,
              decoration: InputDecoration(labelText: 'Required power (hp)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null) {
                  return "Field can not be Empity";
                }
                return null;
              },
              onSaved: (value) {},
            ),
          if (attachmenttype == "Trailer") Trailer(),
          if (attachmenttype == "Other")
            TextFormField(
              controller: _additionalinformation,
              decoration: InputDecoration(labelText: 'Additional Information'),
              validator: (value) {
                if (value == null) {
                  return "Field can not be Empity";
                }
                return null;
              },
              onSaved: (value) {},
            ),
          machineStatusSelector(context),
          Row(
            children: [
              SizedBox(
                // width: MediaQuery.of(context).size.width - 322,
                child: Text(
                  "Select  Image",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              addHorizontalSpace(40),
              Stack(
                children: [
                  buildImage(),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: buildEditIcon(context, Colors.green),
                  ),
                ],
              ),
            ],
          ),
          addVerticalSpace(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<MachineStatusProvider>(
                builder: (context, value, child) => ElevatedButton(
                  onPressed: () async {
                    _selectedStatus = value.selectedAccount;
                    String? userid = await storage.read(key: "userid");

                    if (_formKey.currentState!.validate()) {
                      if (attachmenttype == "Disc Plough") {
                        Map<String, String> data = {
                          "model": _model.text,
                          "manufacturer": _manufacturer.text,
                          "type": _currentCarType,
                          "attachment_type": _currentTractorAttachmentsType,
                          "owner_id": userid!,
                          "status": _selectedStatus!,
                          "discs": _numberofdiscs.text,
                        };

                        var response = await networkHandler.post(
                            "/api/machinery/", data, "machineData",
                            imageFile: imageFile!);

                        if (response.statusCode == 201) {
                          print("Posted");

                          Navigator.pushNamed(context, '/');
                        } else {
                          print("faild");
                          print(response.body.toString());

                          setState(() {
                            // validate = false;
                            // errorText = output;
                          });
                        }
                      } else if (attachmenttype == "Disc Harrow") {
                        Map<String, String> data = {
                          "model": _model.text,
                          "manufacturer": _manufacturer.text,
                          "type": _currentCarType,
                          "owner_id": userid!,
                          "status": _selectedStatus!,
                          "attachment_type": _currentTractorAttachmentsType,
                          "discs": _numberofdiscs.text,
                        };

                        var response = await networkHandler.post(
                            "/api/machinery/", data, "machineData",
                            imageFile: imageFile!);

                        if (response.statusCode == 201) {
                          print("Posted");

                          Navigator.pushNamed(context, '/');
                        } else {
                          print("faild");
                          print(response.body.toString());

                          setState(() {
                            // validate = false;
                            // errorText = output;
                          });
                        }
                      } else if (attachmenttype == "Planter") {
                        Map<String, String> data = {
                          "model": _model.text,
                          "manufacturer": _manufacturer.text,
                          "type": _currentCarType,
                          "owner_id": userid!,
                          "status": _selectedStatus!,
                          "attachment_type": _currentTractorAttachmentsType,
                          "rows": _numberofrows.text,
                        };

                        var response = await networkHandler.post(
                            "/api/machinery/", data, "machineData",
                            imageFile: imageFile!);

                        if (response.statusCode == 201) {
                          print("Posted");

                          Navigator.pushNamed(context, '/');
                        } else {
                          print("faild");
                          print(response.body.toString());

                          setState(() {
                            // validate = false;
                            // errorText = output;
                          });
                        }
                      } else if (attachmenttype == "Sprayer") {
                        Map<String, String> data = {
                          "model": _model.text,
                          "manufacturer": _manufacturer.text,
                          "type": _currentCarType,
                          "owner_id": userid!,
                          "status": _selectedStatus!,
                          "tank_capacity": _tankcapacity.text,
                          "attachment_type": _currentTractorAttachmentsType,
                        };

                        var response = await networkHandler.post(
                            "/api/machinery/", data, "machineData",
                            imageFile: imageFile!);

                        if (response.statusCode == 201) {
                          print("Posted");

                          Navigator.pushNamed(context, '/');
                        } else {
                          print("faild");
                          print(response.body.toString());

                          setState(() {
                            // validate = false;
                            // errorText = output;
                          });
                        }
                      } else if (attachmenttype == "Baler") {
                        Map<String, String> data = {
                          "model": _model.text,
                          "manufacturer": _manufacturer.text,
                          "type": _currentCarType,
                          "owner_id": userid!,
                          "status": _selectedStatus!,
                          "attachment_type": _currentTractorAttachmentsType,
                          "required_power": _requiredpower.text,
                        };

                        var response = await networkHandler.post(
                            "/api/machinery/", data, "machineData",
                            imageFile: imageFile!);

                        if (response.statusCode == 201) {
                          print("Posted");

                          Navigator.pushNamed(context, '/');
                        } else {
                          print("faild");
                          print(response.body.toString());

                          setState(() {
                            // validate = false;
                            // errorText = output;
                          });
                        }
                      } else if (attachmenttype == "Trailer") {
                        Map<String, String> data = {
                          "model": _model.text,
                          "manufacturer": _manufacturer.text,
                          "type": _currentCarType,
                          "owner_id": userid!,
                          "attachment_type": _currentTractorAttachmentsType,
                          "status": _selectedStatus!,
                          "loading_capaciity": _loadingcapacity.text,
                          "platform_length": _platformdimension.text,
                          "sideboard_height": _sideboardheight.text,
                          "num_tires": _numberoftires.text,
                        };

                        var response = await networkHandler.post(
                            "/api/machinery/", data, "machineData",
                            imageFile: imageFile!);

                        if (response.statusCode == 201) {
                          print("Posted");

                          Navigator.pushNamed(context, '/');
                        } else {
                          print("faild");
                          print(response.body.toString());

                          setState(() {
                            // validate = false;
                            // errorText = output;
                          });
                        }
                      } else if (attachmenttype == "Other") {
                        Map<String, String> data = {
                          "model": _model.text,
                          "manufacturer": _manufacturer.text,
                          "type": _currentCarType,
                          "owner_id": userid!,
                          "attachment_type": _currentTractorAttachmentsType,
                          "status": _selectedStatus!,
                          "additional_info": _additionalinformation.text,
                        };

                        var response = await networkHandler.post(
                            "/api/machinery/", data, "machineData",
                            imageFile: imageFile!);

                        if (response.statusCode == 201) {
                          print("Posted");

                          Navigator.pushNamed(context, '/');
                        } else {
                          print("faild");
                          print(response.body.toString());

                          setState(() {
                            // validate = false;
                            // errorText = output;
                          });
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: const Center(
                      child: Text(
                        "Verify",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              addHorizontalSpace(25),
              Button(context, "cancel", '/', Colors.grey, 325, 40),
            ],
          ),
        ],
      ),
    );
  }

  Trailer() {
    return Container(
      child: Column(
        children: [
          TextFormField(
            controller: _loadingcapacity,
            decoration: InputDecoration(labelText: 'Loading Capacity (ton)'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null) {
                return "MField can not be Empity";
              }
              return null;
            },
            onSaved: (value) {},
          ),
          TextFormField(
            controller: _platformdimension,
            decoration: InputDecoration(labelText: 'Platform dimension(m)'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null) {
                return "Field can not be Empity";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _sideboardheight,
            decoration: InputDecoration(labelText: 'Sideboard Height (m)'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null) {
                return "Field can not be Empity";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _numberoftires,
            decoration: InputDecoration(labelText: 'Number of tires'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null) {
                return "Field can not be Empity";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTractorAttachmentsInputs() {
    return Column(
      children: [
        Row(
          children: [
            Radio(
              activeColor: Theme.of(context).primaryColor,
              value: 'Disc Plough',
              groupValue: _currentTractorAttachmentsType,
              onChanged: (value) {
                setState(() {
                  _currentTractorAttachmentsType = value!;
                });
              },
            ),
            Text('Disc Plough'),
            Radio(
              activeColor: Theme.of(context).primaryColor,
              value: 'Disc Harrow',
              groupValue: _currentTractorAttachmentsType,
              onChanged: (value) {
                setState(() {
                  _currentTractorAttachmentsType = value!;
                });
              },
            ),
            Text('Disc Harrow '),
            Radio(
              activeColor: Theme.of(context).primaryColor,
              value: 'Planter',
              groupValue: _currentTractorAttachmentsType,
              onChanged: (value) {
                setState(() {
                  _currentTractorAttachmentsType = value!;
                });
              },
            ),
            Text('Planter'),
          ],
        ),
        Row(
          children: [
            Radio(
              activeColor: Theme.of(context).primaryColor,
              value: 'Sprayer',
              groupValue: _currentTractorAttachmentsType,
              onChanged: (value) {
                setState(() {
                  _currentTractorAttachmentsType = value!;
                });
              },
            ),
            Text('Sprayer'),
            Radio(
              activeColor: Theme.of(context).primaryColor,
              value: 'Baler',
              groupValue: _currentTractorAttachmentsType,
              onChanged: (value) {
                setState(() {
                  _currentTractorAttachmentsType = value!;
                });
              },
            ),
            Text('Baler'),
            Radio(
              activeColor: Theme.of(context).primaryColor,
              value: 'Trailer',
              groupValue: _currentTractorAttachmentsType,
              onChanged: (value) {
                setState(() {
                  _currentTractorAttachmentsType = value!;
                });
              },
            ),
            Text('Trailer'),
            Radio(
              value: 'Other',
              activeColor: Theme.of(context).primaryColor,
              groupValue: _currentTractorAttachmentsType,
              onChanged: (value) {
                setState(() {
                  _currentTractorAttachmentsType = value!;
                });
              },
            ),
            Text('Other '),
          ],
        ),
      ],
    );
  }
}

class newmachineInput extends StatelessWidget {
  const newmachineInput({
    super.key,
    required this.context,
    required this.keybordtype,
    required this.labletext,
    required this.icon,
    required TextEditingController manufacturer,
    required this.widthl,
  }) : _manufacturer = manufacturer;

  final BuildContext context;
  final TextInputType keybordtype;
  final String labletext;
  final IconData icon;
  final double widthl;
  final TextEditingController _manufacturer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthl,
      height: MediaQuery.of(context).size.height * 0.08,
      child: TextFormField(
        controller: _manufacturer,
        keyboardType: keybordtype,
        obscureText: false,
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
          labelText: labletext,
          // hintText: "manufacturer",
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
}
