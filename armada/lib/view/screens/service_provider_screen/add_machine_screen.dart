import 'package:flutter/material.dart';
import 'package:armada/utils/helper_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../widgets/widgets.dart';

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
  // late File _image;
  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              addVerticalSpace(55.0),
              Text('Select a car type:'),
              Column(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 'Tractor',
                        groupValue: _currentCarType,
                        onChanged: (value) {
                          setState(() {
                            _currentCarType = value!;
                          });
                        },
                      ),
                      Text('Tractor'),
                      Radio(
                        value: 'Combineharvester',
                        groupValue: _currentCarType,
                        onChanged: (value) {
                          setState(() {
                            _currentCarType = value!;
                          });
                        },
                      ),
                      Text('Combine harvester'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'Thresher',
                        groupValue: _currentCarType,
                        onChanged: (value) {
                          setState(() {
                            _currentCarType = value!;
                          });
                        },
                      ),
                      Text('Thresher'),
                      Radio(
                        value: 'TractorAttachments',
                        groupValue: _currentCarType,
                        onChanged: (value) {
                          setState(() {
                            _currentCarType = value!;
                          });
                        },
                      ),
                      Text('Tractor Attachments'),
                      Radio(
                        value: 'Other',
                        groupValue: _currentCarType,
                        onChanged: (value) {
                          setState(() {
                            _currentCarType = value!;
                          });
                        },
                      ),
                      Text('Other'),
                    ],
                  ),
                ],
              ),
              if (_currentCarType == 'Tractor') _buildSedanInputs(),
              if (_currentCarType == 'Combineharvester') _buildSUVInputs(),
              if (_currentCarType == 'Thresher') _buildHatchbackInputs(),
              if (_currentCarType == 'TractorAttachments')
                _buildPickupTruckInputs(),
              if (_currentCarType == 'Other') _buildHatchbackInputsO(),
              if (_currentCarType == 'TractorAttachments')
                if (_currentTractorAttachmentsType == 'DiscPlough')
                  _buildSedanInputss(),
              if (_currentCarType == 'TractorAttachments')
                if (_currentTractorAttachmentsType == 'DiscHarrow')
                  _buildSedanInputsu(),
              if (_currentCarType == 'TractorAttachments')
                if (_currentTractorAttachmentsType == 'Planter')
                  _buildSedanInputsv(),
              if (_currentCarType == 'TractorAttachments')
                if (_currentTractorAttachmentsType == 'Sprayer')
                  _buildSedanInputsw(),
              if (_currentCarType == 'TractorAttachments')
                if (_currentTractorAttachmentsType == 'Baler')
                  _buildSedanInputsx(),
              if (_currentCarType == 'TractorAttachments')
                if (_currentTractorAttachmentsType == 'Trailer')
                  _buildSedanInputsy(),
              if (_currentCarType == 'TractorAttachments')
                if (_currentTractorAttachmentsType == 'Other')
                  _buildSedanInputsz(),
              addVerticalSpace(50),
              if (_currentCarType != '' &&
                  _currentCarType != 'TractorAttachments')
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(context, "Verify", '/',
                        Theme.of(context).primaryColor, 200, 50),
                    addHorizontalSpace(25),
                    Button(context, "cancel", '/', Colors.grey, 325, 40),
                  ],
                ),
              if (_currentCarType == 'TractorAttachments' &&
                  _currentTractorAttachmentsType != '')
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(context, "Verify", '/',
                        Theme.of(context).primaryColor, 200, 50),
                    addHorizontalSpace(25),
                    Button(context, "cancel", '/', Colors.grey, 325, 40),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSedanInputs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Year'),
          validator: (value) {},
          onSaved: (value) {
            // Provider.of<Sedan>(context, listen: false).color = value;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Horsepower '),
          keyboardType: TextInputType.number,
          validator: (value) {},
          onSaved: (value) {
            // Provider.of<Sedan>(context, listen: false).year = int.parse(value);
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Hour meter'),
          validator: (value) {},
          onSaved: (value) {
            // Provider.of<Sedan>(context, listen: false).color = value;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Region'),
          validator: (value) {},
          onSaved: (value) {
            // Provider.of<Sedan>(context, listen: false).color = value;
          },
        ),
        machineStatusSelector(context),
        // buildImage(),
        Center(
          child: Stack(
            children: [
              buildImage(),
              Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(context, Colors.red),
              ),
            ],
          ),
        ),
      ],
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
          "Choose Profile Photo",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                takePhote(ImageSource.camera);
              },
              icon: Icon(Icons.camera),
              label: Text("Camera"),
            ),
            ElevatedButton.icon(
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
      height: 100,
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
          width: 128,
          height: 128,
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

  Widget _buildSUVInputs() {
    // Return input fields for SUV class
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {},
          onSaved: (value) {
            // Provider.of<Sedan>(context, listen: false).color = value;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Year'),
          keyboardType: TextInputType.number,
          validator: (value) {},
          onSaved: (value) {
            // Provider.of<Sedan>(context, listen: false).year = int.parse(value);
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Grain Tank Capacity'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Grain Types'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Region'),
          keyboardType: TextInputType.number,
          validator: (value) {},
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
        Center(
          child: Stack(
            children: [
              buildImage(),
              Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(context, Colors.red),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildHatchbackInputs() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Required power (hp)'),
          keyboardType: TextInputType.number,
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Working Capacity (kg/hr)'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Region'),
          keyboardType: TextInputType.number,
          validator: (value) {},
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
        Center(
          child: Stack(
            children: [
              buildImage(),
              Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(context, Colors.red),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildHatchbackInputsO() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Additional Information'),
          keyboardType: TextInputType.number,
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Region'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
        Center(
          child: Stack(
            children: [
              buildImage(),
              Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(context, Colors.red),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPickupTruckInputs() {
    return Column(
      children: [
        Row(
          children: [
            Radio(
              value: 'DiscPlough',
              groupValue: _currentTractorAttachmentsType,
              onChanged: (value) {
                setState(() {
                  _currentTractorAttachmentsType = value!;
                });
              },
            ),
            Text('Disc Plough'),
            Radio(
              value: 'DiscHarrow',
              groupValue: _currentTractorAttachmentsType,
              onChanged: (value) {
                setState(() {
                  _currentTractorAttachmentsType = value!;
                });
              },
            ),
            Text('Disc Harrow '),
            Radio(
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

  Widget _buildSedanInputss() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Number of Discs'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
        Center(
          child: Stack(
            children: [
              buildImage(),
              Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(context, Colors.red),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSedanInputst() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Number of Discs'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
        Center(
          child: Stack(
            children: [
              buildImage(),
              Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(context, Colors.red),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSedanInputsu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Number of Discs'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
        Center(
          child: Stack(
            children: [
              buildImage(),
              Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(context, Colors.red),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSedanInputsv() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Number of Rows'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
        Center(
          child: Stack(
            children: [
              buildImage(),
              Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(context, Colors.red),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSedanInputsw() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Tank Capacity'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
        Center(
          child: Stack(
            children: [
              buildImage(),
              Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(context, Colors.red),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSedanInputsx() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Required power (hp)'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
        Center(
          child: Stack(
            children: [
              buildImage(),
              Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(context, Colors.red),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSedanInputsy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Loading Capacity (ton)'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Platform dimension(m)'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Sideboard Height (m)'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Number of tires'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
        Center(
          child: Stack(
            children: [
              buildImage(),
              Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(context, Colors.red),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSedanInputsz() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Additional Information'),
          validator: (value) {},
          onSaved: (value) {},
        ),
        machineStatusSelector(context),
        Center(
          child: Stack(
            children: [
              buildImage(),
              Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(context, Colors.red),
              ),
            ],
          ),
        )
      ],
    );
  }
}
