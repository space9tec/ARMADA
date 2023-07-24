// import 'package:flutter/material.dart';
// import 'package:armada/utils/helper_widget.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'dart:io';
// import '../../../provider/machine_status_provider.dart';
// import '../../widgets/widgets.dart';
// import 'package:armada/networkhandler.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:bot_toast/bot_toast.dart';

// class VerifyServiceProvider extends StatefulWidget {
//   static const String routeName = '/VerifyServiceProvider';

//   static Route route() {
//     return MaterialPageRoute(
//       settings: const RouteSettings(name: routeName),
//       builder: (context) {
//         return const VerifyServiceProvider();
//       },
//     );
//   }

//   const VerifyServiceProvider({super.key});

//   @override
//   State<VerifyServiceProvider> createState() => _VerifyServiceProviderState();
// }

// class _VerifyServiceProviderState extends State<VerifyServiceProvider> {
//   String _currentCarType = '';
//   String _currentTractorAttachmentsType = '';

//   final TextEditingController _manufacturer = TextEditingController();
//   final TextEditingController _model = TextEditingController();
//   final TextEditingController _year = TextEditingController();
//   final TextEditingController _horsepower = TextEditingController();
//   final TextEditingController _hourmeter = TextEditingController();
//   final TextEditingController _region = TextEditingController();

//   final TextEditingController _requiredpower = TextEditingController();
//   final TextEditingController _workingcapacity = TextEditingController();
//   final TextEditingController _graintank = TextEditingController();
//   final TextEditingController _graintypes = TextEditingController();
//   final TextEditingController _additionalinformation = TextEditingController();
//   final TextEditingController _numberofdiscs = TextEditingController();
//   final TextEditingController _numberofrows = TextEditingController();
//   final TextEditingController _tankcapacity = TextEditingController();
//   final TextEditingController _numberoftires = TextEditingController();
//   final TextEditingController _sideboardheight = TextEditingController();
//   final TextEditingController _platformdimension = TextEditingController();
//   final TextEditingController _loadingcapacity = TextEditingController();
//   String? _selectedStatus;

//   NetworkHandler networkHandler = NetworkHandler();
//   final storage = const FlutterSecureStorage();

//   XFile? imageFile;
//   final ImagePicker picker = ImagePicker();

//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               addVerticalSpace(50.0),

//               Text(
//                 "Verify Account",
//                 style: Theme.of(context).textTheme.displayLarge,
//               ),
//               addVerticalSpace(40.0),
//               const Text('Select a Machinery type:'),
//               Column(
//                 children: [
//                   Row(
//                     children: [
//                       Radio(
//                         value: 'Tractor',
//                         groupValue: _currentCarType,
//                         onChanged: (value) {
//                           setState(() {
//                             _currentCarType = value!;
//                           });
//                         },
//                       ),
//                       Text('Tractor'),
//                       Radio(
//                         value: 'Combine Harvester',
//                         groupValue: _currentCarType,
//                         onChanged: (value) {
//                           setState(() {
//                             _currentCarType = value!;
//                           });
//                         },
//                       ),
//                       Text('Combine harvester'),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Radio(
//                         value: 'Thresher',
//                         groupValue: _currentCarType,
//                         onChanged: (value) {
//                           setState(() {
//                             _currentCarType = value!;
//                           });
//                         },
//                       ),
//                       Text('Thresher'),
//                       Radio(
//                         value: 'Tractor Attachment',
//                         groupValue: _currentCarType,
//                         onChanged: (value) {
//                           setState(() {
//                             _currentCarType = value!;
//                           });
//                         },
//                       ),
//                       Text('Tractor Attachments'),
//                       Radio(
//                         value: 'Other',
//                         groupValue: _currentCarType,
//                         onChanged: (value) {
//                           setState(() {
//                             _currentCarType = value!;
//                           });
//                         },
//                       ),
//                       Text('Other'),
//                     ],
//                   ),
//                 ],
//               ),
//               if (_currentCarType == 'Tractor')
//                 _buildTractorInputs(_currentCarType),
//               if (_currentCarType == 'Combine Harvester')
//                 _buildTractorInputs(_currentCarType),
//               if (_currentCarType == 'Thresher')
//                 _buildTractorInputs(_currentCarType),
//               if (_currentCarType == 'Tractor Attachment')
//                 _buildTractorAttachmentsInputs(),
//               if (_currentCarType == 'Other')
//                 _buildTractorInputs(_currentCarType),
//               if (_currentCarType == 'Tractor Attachment')
//                 if (_currentTractorAttachmentsType == 'Disc Plough')
//                   _buildSedanInputs(_currentTractorAttachmentsType),
//               if (_currentCarType == 'Tractor Attachment')
//                 if (_currentTractorAttachmentsType == 'Disc Harrow')
//                   _buildSedanInputs(_currentTractorAttachmentsType),
//               if (_currentCarType == 'Tractor Attachment')
//                 if (_currentTractorAttachmentsType == 'Planter')
//                   _buildSedanInputs(_currentTractorAttachmentsType),
//               if (_currentCarType == 'Tractor Attachment')
//                 if (_currentTractorAttachmentsType == 'Sprayer')
//                   _buildSedanInputs(_currentTractorAttachmentsType),
//               if (_currentCarType == 'Tractor Attachment')
//                 if (_currentTractorAttachmentsType == 'Baler')
//                   _buildSedanInputs(_currentTractorAttachmentsType),
//               if (_currentCarType == 'Tractor Attachment')
//                 if (_currentTractorAttachmentsType == 'Trailer')
//                   _buildSedanInputs(_currentTractorAttachmentsType),
//               if (_currentCarType == 'Tractor Attachment')
//                 if (_currentTractorAttachmentsType == 'Other')
//                   _buildSedanInputs(_currentTractorAttachmentsType),
//               addVerticalSpace(50),
//               // if (_currentCarType == 'TractorAttachments' &&
//               //     _currentTractorAttachmentsType != '')
//               //   Row(
//               //     mainAxisAlignment: MainAxisAlignment.center,
//               //     children: [
//               //       Button(context, "Verify", '/',
//               //           Theme.of(context).primaryColor, 200, 50),
//               //       addHorizontalSpace(25),
//               //       Button(context, "cancel", '/', Colors.grey, 325, 40),
//               //     ],
//               //   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTractorInputs(String machintype) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.71,
//             height: MediaQuery.of(context).size.height * 0.08,
//             child: TextFormField(
//               controller: _manufacturer,
//               decoration: const InputDecoration(labelText: 'Manufacturer'),
//               validator: (value) {
//                 if (value == null) {
//                   return "Can not be Empity";
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.71,
//             height: MediaQuery.of(context).size.height * 0.08,
//             child: TextFormField(
//               controller: _model,
//               decoration: const InputDecoration(labelText: 'Model'),
//               validator: (value) {
//                 if (value == null) {
//                   return "Can not be Empity";
//                 }
//                 return null;
//               },
//             ),
//           ),
//           if (machintype == "Tractor") tractor(),
//           if (machintype == "Combine Harvester") Combineharvester(),
//           if (machintype == "Thresher") Thresher(),
//           if (machintype == "Other") Other(),
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.71,
//             height: MediaQuery.of(context).size.height * 0.08,
//             child: TextFormField(
//               controller: _region,
//               decoration: const InputDecoration(labelText: 'Region'),
//               validator: (value) {
//                 if (value == null) {
//                   return "Can not be Empity";
//                 }
//                 return null;
//               },
//               onSaved: (value) {},
//             ),
//           ),
//           addVerticalSpace(5),
//           machineStatusSelector(context),
//           Row(
//             children: [
//               SizedBox(
//                 // width: MediaQuery.of(context).size.width - 322,
//                 child: Text(
//                   "Select  Image",
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//               ),
//               addHorizontalSpace(40),
//               Stack(
//                 children: [
//                   buildImage(),
//                   Positioned(
//                     bottom: 0,
//                     right: 4,
//                     child: buildEditIcon(context, Colors.green),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           addVerticalSpace(15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Consumer<MachineStatusProvider>(
//                 builder: (context, value, child) => ElevatedButton(
//                   onPressed: () async {
//                     _selectedStatus = value.selectedAccount;
//                     String? userid = await storage.read(key: "userid");

//                     if (_formKey.currentState!.validate()) {
//                       if (machintype == "Tractor") {
//                         Map<String, String> data = {
//                           "model": _model.text,
//                           "manufacturer": _manufacturer.text,
//                           "type": _currentCarType,
//                           "owner_id": userid!,
//                           "status": _selectedStatus!,
//                           "year": _year.text,
//                           "region": _region.text,
//                           "hour_meter": _hourmeter.text,
//                           "horsepower": _horsepower.text,
//                         };

//                         var response = await networkHandler.post(
//                             "/api/machinery/", data, "machineData",
//                             imageFile: imageFile!);

//                         if (response.statusCode == 201) {
//                           print("Posted");
//                           BotToast.showText(
//                             text: "successfully Posted.",
//                             duration: Duration(seconds: 2),
//                             contentColor: Colors.white,
//                             textStyle: TextStyle(
//                                 fontSize: 16.0, color: Color(0xFF006837)),
//                           );
//                           Navigator.pushNamed(context, '/');
//                         } else {
//                           print("faild");
//                           print(response.body.toString());
//                           BotToast.showText(
//                             text: "Posting Failed.",
//                             duration: Duration(seconds: 2),
//                             contentColor: Colors.white,
//                             textStyle: TextStyle(
//                                 fontSize: 16.0, color: Color(0xFF006837)),
//                           );
//                           setState(() {
//                             // validate = false;
//                             // errorText = output;
//                           });
//                         }
//                       } else if (machintype == "Combine Harvester") {
//                         Map<String, String> data = {
//                           "model": _model.text,
//                           "manufacturer": _manufacturer.text,
//                           "type": _currentCarType,
//                           "owner_id": userid!,
//                           "status": _selectedStatus!,
//                           "year": _year.text,
//                           "region": _region.text,
//                           "grain_tank_capacity": _graintank.text,
//                           "grain_types": _graintypes.text,
//                         };

//                         var response = await networkHandler.post(
//                             "/api/machinery/", data, "machineData",
//                             imageFile: imageFile!);

//                         if (response.statusCode == 201) {
//                           print("Posted");
//                           BotToast.showText(
//                             text: "successfully Posted.",
//                             duration: Duration(seconds: 2),
//                             contentColor: Colors.white,
//                             textStyle: TextStyle(
//                                 fontSize: 16.0, color: Color(0xFF006837)),
//                           );
//                           Navigator.pushNamed(context, '/');
//                         } else {
//                           print("faild");
//                           print(response.body.toString());

//                           setState(() {
//                             // validate = false;
//                             // errorText = output;
//                           });
//                         }
//                       } else if (machintype == "Thresher") {
//                         Map<String, String> data = {
//                           "model": _model.text,
//                           "manufacturer": _manufacturer.text,
//                           "type": _currentCarType,
//                           "owner_id": userid!,
//                           "status": _selectedStatus!,
//                           "year": _year.text,
//                           "region": _region.text,
//                           "working_capacity": _workingcapacity.text,
//                           "required_power": _requiredpower.text,
//                         };

//                         var response = await networkHandler.post(
//                             "/api/machinery/", data, "machineData",
//                             imageFile: imageFile!);

//                         if (response.statusCode == 201) {
//                           print("Posted");
//                           BotToast.showText(
//                             text: "successfully Posted.",
//                             duration: Duration(seconds: 2),
//                             contentColor: Colors.white,
//                             textStyle: TextStyle(
//                                 fontSize: 16.0, color: Color(0xFF006837)),
//                           );
//                           Navigator.pushNamed(context, '/');
//                         } else {
//                           print("faild");
//                           print(response.body.toString());

//                           setState(() {
//                             // validate = false;
//                             // errorText = output;
//                           });
//                         }
//                       } else if (machintype == "Other") {
//                         Map<String, String> data = {
//                           "model": _model.text,
//                           "manufacturer": _manufacturer.text,
//                           "type": _currentCarType,
//                           "owner_id": userid!,
//                           "status": _selectedStatus!,
//                           "region": _region.text,
//                           "additional_info": _additionalinformation.text,
//                         };

//                         var response = await networkHandler.post(
//                             "/api/machinery/", data, "machineData",
//                             imageFile: imageFile!);

//                         if (response.statusCode == 201) {
//                           print("Posted");
//                           BotToast.showText(
//                             text: "successfully Posted.",
//                             duration: Duration(seconds: 2),
//                             contentColor: Colors.white,
//                             textStyle: TextStyle(
//                                 fontSize: 16.0, color: Color(0xFF006837)),
//                           );
//                           Navigator.pushNamed(context, '/');
//                         } else {
//                           print("faild");
//                           print(response.body.toString());

//                           setState(() {
//                             // validate = false;
//                             // errorText = output;
//                           });
//                         }
//                       } else if (machintype == "Tractor") {
//                         Map<String, String> data = {
//                           "model": _model.text,
//                           "manufacturer": _manufacturer.text,
//                           "type": _currentCarType,
//                           "owner_id": userid!,
//                           "status": _selectedStatus!,
//                           "year": _year.text,
//                           "region": _region.text,
//                           "hour_meter": _hourmeter.text,
//                           "horsepower": _horsepower.text,
//                         };

//                         var response = await networkHandler.post(
//                             "/api/machinery/", data, "machineData",
//                             imageFile: imageFile!);

//                         if (response.statusCode == 201) {
//                           print("Posted");
//                           BotToast.showText(
//                             text: "successfully Posted.",
//                             duration: Duration(seconds: 2),
//                             contentColor: Colors.white,
//                             textStyle: TextStyle(
//                                 fontSize: 16.0, color: Color(0xFF006837)),
//                           );
//                           Navigator.pushNamed(context, '/');
//                         } else {
//                           print("faild");
//                           print(response.body.toString());

//                           setState(() {
//                             // validate = false;
//                             // errorText = output;
//                           });
//                         }
//                       }
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).primaryColor,
//                   ),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width - 200,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Theme.of(context).primaryColor,
//                     ),
//                     child: const Center(
//                       child: Text(
//                         "Verify",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               addHorizontalSpace(25),
//               Button(context, "cancel", '/', Colors.grey, 325, 40),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildEditIcon(context, Color color) => buildCircle(
//         color: Colors.white,
//         all: 3,
//         child: buildCircle(
//           color: color,
//           all: 8,
//           child: InkWell(
//             onTap: () {
//               // Navigator.pushNamed(context, '/edit_farmer_profile');

//               showModalBottomSheet(
//                 context: context,
//                 builder: ((builder) => bottomSheat()),
//               );
//             },
//             child: Icon(
//               Icons.edit,
//               color: Colors.white,
//               size: 20,
//             ),
//           ),
//         ),
//       );

//   Widget bottomSheat() {
//     return Container(
//       height: 100,
//       width: 300,
//       margin: const EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 20,
//       ),
//       child: Column(children: [
//         const Text(
//           "Choose Machinery Photo",
//           style: TextStyle(fontSize: 20),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                   elevation: 0,
//                   backgroundColor: Theme.of(context).primaryColor),
//               onPressed: () {
//                 takePhote(ImageSource.camera);
//               },
//               icon: Icon(Icons.camera),
//               label: Text("Camera"),
//             ),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                   elevation: 0,
//                   backgroundColor: Theme.of(context).primaryColor),
//               onPressed: () {
//                 takePhote(ImageSource.gallery);
//               },
//               icon: Icon(Icons.image),
//               label: Text("Gallery"),
//             )
//           ],
//         )
//       ]),
//     );
//   }

//   Widget buildCircle({
//     required Widget child,
//     required double all,
//     required Color color,
//   }) =>
//       ClipOval(
//         child: Container(
//           padding: EdgeInsets.all(all),
//           color: color,
//           child: child,
//         ),
//       );

//   Widget buildImage() {
//     // final image = NetworkImage(widget.imagePath);
//     final image = Image.asset(
//       fit: BoxFit.scaleDown,
//       height: 100,
//       "assets/images/tracter1.png",
//     );

//     return ClipOval(
//       child: Material(
//         color: Colors.transparent,
//         child: Ink.image(
//           image: imageFile == null
//               ? image.image
//               : FileImage(File(imageFile!.path)),
//           fit: BoxFit.cover,
//           width: 128,
//           height: 128,
//           child: InkWell(
//             onTap: () {},
//           ),
//         ),
//       ),
//     );
//   }

//   void takePhote(ImageSource source) async {
//     XFile? pickedFile = await picker.pickImage(source: source);

//     setState(() {
//       imageFile = pickedFile;
//     });
//   }

//   tractor() {
//     return Container(
//       child: Column(
//         // crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.71,
//             height: MediaQuery.of(context).size.height * 0.08,
//             child: TextFormField(
//               controller: _year,
//               decoration: const InputDecoration(labelText: 'Year'),
//               validator: (value) {
//                 if (value == null) {
//                   return "Can not be Empity";
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.71,
//             height: MediaQuery.of(context).size.height * 0.08,
//             child: TextFormField(
//               controller: _horsepower,
//               decoration: const InputDecoration(labelText: 'Horsepower '),
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value == null) {
//                   return "Can not be Empity";
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.71,
//             height: MediaQuery.of(context).size.height * 0.08,
//             child: TextFormField(
//               controller: _hourmeter,
//               decoration: const InputDecoration(labelText: 'Hour meter'),
//               validator: (value) {
//                 if (value == null) {
//                   return "Can not be Empity";
//                 }
//                 return null;
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Combineharvester() {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           TextFormField(
//             controller: _year,
//             decoration: const InputDecoration(labelText: 'Year'),
//             validator: (value) {
//               if (value == null) {
//                 return "Can not be Empity";
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: _graintank,
//             decoration: const InputDecoration(labelText: 'Grain Tank Capacity'),
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               if (value == null) {
//                 return "Can not be Empity";
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: _graintypes,
//             decoration: const InputDecoration(labelText: 'Grain Types'),
//             validator: (value) {
//               if (value == null) {
//                 return "Can not be Empity";
//               }
//               return null;
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Thresher() {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           TextFormField(
//             controller: _year,
//             decoration: const InputDecoration(labelText: 'Year'),
//             validator: (value) {
//               if (value == null) {
//                 return "Can not be Empity";
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: _requiredpower,
//             decoration: const InputDecoration(labelText: 'Required power (hp)'),
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               if (value == null) {
//                 return "Can not be Empity";
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: _workingcapacity,
//             decoration:
//                 const InputDecoration(labelText: 'Working Capacity (kg/hr)'),
//             validator: (value) {
//               if (value == null) {
//                 return "Can not be Empity";
//               }
//               return null;
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Other() {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           TextFormField(
//             controller: _additionalinformation,
//             decoration:
//                 const InputDecoration(labelText: 'Additional Information'),
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               if (value == null) {
//                 return "Can not be Empity";
//               }
//               return null;
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSedanInputs(String attachmenttype) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           TextFormField(
//             controller: _manufacturer,
//             decoration: InputDecoration(labelText: 'Manufacturer'),
//             validator: (value) {
//               if (value == null) {
//                 return "Field can not be Empity";
//               }
//               return null;
//             },
//             onSaved: (value) {},
//           ),
//           TextFormField(
//             controller: _model,
//             decoration: InputDecoration(labelText: 'Model'),
//             validator: (value) {
//               if (value == null) {
//                 return "Field can not be Empity";
//               }
//               return null;
//             },
//             onSaved: (value) {},
//           ),
//           if (attachmenttype == "Disc Plough")
//             TextFormField(
//               controller: _numberofdiscs,
//               decoration: InputDecoration(labelText: 'Number of Discs'),
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value == null) {
//                   return "Field can not be Empity";
//                 }
//                 return null;
//               },
//               onSaved: (value) {},
//             ),
//           if (attachmenttype == "Disc Harrow")
//             TextFormField(
//               controller: _numberofdiscs,
//               decoration: InputDecoration(labelText: 'Number of Discs'),
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value == null) {
//                   return "Field can not be Empity";
//                 }
//                 return null;
//               },
//               onSaved: (value) {},
//             ),
//           if (attachmenttype == "Planter")
//             TextFormField(
//               controller: _numberofrows,
//               decoration: InputDecoration(labelText: 'Number of Rows'),
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value == null) {
//                   return "Field can not be Empity";
//                 }
//                 return null;
//               },
//               onSaved: (value) {},
//             ),
//           if (attachmenttype == "Sprayer")
//             TextFormField(
//               controller: _tankcapacity,
//               decoration: InputDecoration(labelText: 'Tank Capacity'),
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value == null) {
//                   return "Field can not be Empity";
//                 }
//                 return null;
//               },
//               onSaved: (value) {},
//             ),
//           if (attachmenttype == "Baler")
//             TextFormField(
//               controller: _requiredpower,
//               decoration: InputDecoration(labelText: 'Required power (hp)'),
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value == null) {
//                   return "Field can not be Empity";
//                 }
//                 return null;
//               },
//               onSaved: (value) {},
//             ),
//           if (attachmenttype == "Trailer") Trailer(),
//           if (attachmenttype == "Other")
//             TextFormField(
//               controller: _additionalinformation,
//               decoration: InputDecoration(labelText: 'Additional Information'),
//               validator: (value) {
//                 if (value == null) {
//                   return "Field can not be Empity";
//                 }
//                 return null;
//               },
//               onSaved: (value) {},
//             ),
//           machineStatusSelector(context),
//           Row(
//             children: [
//               SizedBox(
//                 // width: MediaQuery.of(context).size.width - 322,
//                 child: Text(
//                   "Select  Image",
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//               ),
//               addHorizontalSpace(40),
//               Stack(
//                 children: [
//                   buildImage(),
//                   Positioned(
//                     bottom: 0,
//                     right: 4,
//                     child: buildEditIcon(context, Colors.green),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           addVerticalSpace(15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Consumer<MachineStatusProvider>(
//                 builder: (context, value, child) => ElevatedButton(
//                   onPressed: () async {
//                     _selectedStatus = value.selectedAccount;
//                     String? userid = await storage.read(key: "userid");

//                     if (_formKey.currentState!.validate()) {
//                       if (attachmenttype == "Disc Plough") {
//                         Map<String, String> data = {
//                           "model": _model.text,
//                           "manufacturer": _manufacturer.text,
//                           "type": _currentCarType,
//                           "attachment_type": _currentTractorAttachmentsType,
//                           "owner_id": userid!,
//                           "status": _selectedStatus!,
//                           "discs": _numberofdiscs.text,
//                         };

//                         var response = await networkHandler.post(
//                             "/api/machinery/", data, "machineData",
//                             imageFile: imageFile!);

//                         if (response.statusCode == 201) {
//                           print("Posted");
//                           BotToast.showText(
//                             text: "successfully Posted.",
//                             duration: Duration(seconds: 2),
//                             contentColor: Colors.white,
//                             textStyle: TextStyle(
//                                 fontSize: 16.0, color: Color(0xFF006837)),
//                           );
//                           Navigator.pushNamed(context, '/');
//                         } else {
//                           print("faild");
//                           print(response.body.toString());

//                           setState(() {
//                             // validate = false;
//                             // errorText = output;
//                           });
//                         }
//                       } else if (attachmenttype == "Disc Harrow") {
//                         Map<String, String> data = {
//                           "model": _model.text,
//                           "manufacturer": _manufacturer.text,
//                           "type": _currentCarType,
//                           "owner_id": userid!,
//                           "status": _selectedStatus!,
//                           "attachment_type": _currentTractorAttachmentsType,
//                           "discs": _numberofdiscs.text,
//                         };

//                         var response = await networkHandler.post(
//                             "/api/machinery/", data, "machineData",
//                             imageFile: imageFile!);

//                         if (response.statusCode == 201) {
//                           print("Posted");
//                           BotToast.showText(
//                             text: "successfully Posted.",
//                             duration: Duration(seconds: 2),
//                             contentColor: Colors.white,
//                             textStyle: TextStyle(
//                                 fontSize: 16.0, color: Color(0xFF006837)),
//                           );
//                           Navigator.pushNamed(context, '/');
//                         } else {
//                           print("faild");
//                           print(response.body.toString());

//                           setState(() {
//                             // validate = false;
//                             // errorText = output;
//                           });
//                         }
//                       } else if (attachmenttype == "Planter") {
//                         Map<String, String> data = {
//                           "model": _model.text,
//                           "manufacturer": _manufacturer.text,
//                           "type": _currentCarType,
//                           "owner_id": userid!,
//                           "status": _selectedStatus!,
//                           "attachment_type": _currentTractorAttachmentsType,
//                           "rows": _numberofrows.text,
//                         };

//                         var response = await networkHandler.post(
//                             "/api/machinery/", data, "machineData",
//                             imageFile: imageFile!);

//                         if (response.statusCode == 201) {
//                           print("Posted");
//                           BotToast.showText(
//                             text: "successfully Posted.",
//                             duration: Duration(seconds: 2),
//                             contentColor: Colors.white,
//                             textStyle: TextStyle(
//                                 fontSize: 16.0, color: Color(0xFF006837)),
//                           );
//                           Navigator.pushNamed(context, '/');
//                         } else {
//                           print("faild");
//                           print(response.body.toString());

//                           setState(() {
//                             // validate = false;
//                             // errorText = output;
//                           });
//                         }
//                       } else if (attachmenttype == "Sprayer") {
//                         Map<String, String> data = {
//                           "model": _model.text,
//                           "manufacturer": _manufacturer.text,
//                           "type": _currentCarType,
//                           "owner_id": userid!,
//                           "status": _selectedStatus!,
//                           "tank_capacity": _tankcapacity.text,
//                           "attachment_type": _currentTractorAttachmentsType,
//                         };

//                         var response = await networkHandler.post(
//                             "/api/machinery/", data, "machineData",
//                             imageFile: imageFile!);

//                         if (response.statusCode == 201) {
//                           print("Posted");
//                           BotToast.showText(
//                             text: "successfully Posted.",
//                             duration: Duration(seconds: 2),
//                             contentColor: Colors.white,
//                             textStyle: TextStyle(
//                                 fontSize: 16.0, color: Color(0xFF006837)),
//                           );
//                           Navigator.pushNamed(context, '/');
//                         } else {
//                           print("faild");
//                           print(response.body.toString());

//                           setState(() {
//                             // validate = false;
//                             // errorText = output;
//                           });
//                         }
//                       } else if (attachmenttype == "Baler") {
//                         Map<String, String> data = {
//                           "model": _model.text,
//                           "manufacturer": _manufacturer.text,
//                           "type": _currentCarType,
//                           "owner_id": userid!,
//                           "status": _selectedStatus!,
//                           "attachment_type": _currentTractorAttachmentsType,
//                           "required_power": _requiredpower.text,
//                         };

//                         var response = await networkHandler.post(
//                             "/api/machinery/", data, "machineData",
//                             imageFile: imageFile!);

//                         if (response.statusCode == 201) {
//                           print("Posted");
//                           BotToast.showText(
//                             text: "successfully Posted.",
//                             duration: Duration(seconds: 2),
//                             contentColor: Colors.white,
//                             textStyle: TextStyle(
//                                 fontSize: 16.0, color: Color(0xFF006837)),
//                           );
//                           Navigator.pushNamed(context, '/');
//                         } else {
//                           print("faild");
//                           print(response.body.toString());

//                           setState(() {
//                             // validate = false;
//                             // errorText = output;
//                           });
//                         }
//                       } else if (attachmenttype == "Trailer") {
//                         Map<String, String> data = {
//                           "model": _model.text,
//                           "manufacturer": _manufacturer.text,
//                           "type": _currentCarType,
//                           "owner_id": userid!,
//                           "attachment_type": _currentTractorAttachmentsType,
//                           "status": _selectedStatus!,
//                           "loading_capaciity": _loadingcapacity.text,
//                           "platform_length": _platformdimension.text,
//                           "sideboard_height": _sideboardheight.text,
//                           "num_tires": _numberoftires.text,
//                         };

//                         var response = await networkHandler.post(
//                             "/api/machinery/", data, "machineData",
//                             imageFile: imageFile!);

//                         if (response.statusCode == 201) {
//                           print("Posted");
//                           BotToast.showText(
//                             text: "successfully Posted.",
//                             duration: Duration(seconds: 2),
//                             contentColor: Colors.white,
//                             textStyle: TextStyle(
//                                 fontSize: 16.0, color: Color(0xFF006837)),
//                           );
//                           Navigator.pushNamed(context, '/');
//                         } else {
//                           print("faild");
//                           print(response.body.toString());

//                           setState(() {
//                             // validate = false;
//                             // errorText = output;
//                           });
//                         }
//                       } else if (attachmenttype == "Other") {
//                         Map<String, String> data = {
//                           "model": _model.text,
//                           "manufacturer": _manufacturer.text,
//                           "type": _currentCarType,
//                           "owner_id": userid!,
//                           "attachment_type": _currentTractorAttachmentsType,
//                           "status": _selectedStatus!,
//                           "additional_info": _additionalinformation.text,
//                         };

//                         var response = await networkHandler.post(
//                             "/api/machinery/", data, "machineData",
//                             imageFile: imageFile!);

//                         if (response.statusCode == 201) {
//                           print("Posted");
//                           BotToast.showText(
//                             text: "successfully Posted.",
//                             duration: Duration(seconds: 2),
//                             contentColor: Colors.white,
//                             textStyle: TextStyle(
//                                 fontSize: 16.0, color: Color(0xFF006837)),
//                           );
//                           Navigator.pushNamed(context, '/');
//                         } else {
//                           print("faild");
//                           print(response.body.toString());

//                           setState(() {
//                             // validate = false;
//                             // errorText = output;
//                           });
//                         }
//                       }
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).primaryColor,
//                   ),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width - 200,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Theme.of(context).primaryColor,
//                     ),
//                     child: const Center(
//                       child: Text(
//                         "Verify",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               addHorizontalSpace(25),
//               Button(context, "cancel", '/', Colors.grey, 325, 40),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Trailer() {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           TextFormField(
//             controller: _loadingcapacity,
//             decoration: InputDecoration(labelText: 'Loading Capacity (ton)'),
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               if (value == null) {
//                 return "MField can not be Empity";
//               }
//               return null;
//             },
//             onSaved: (value) {},
//           ),
//           TextFormField(
//             controller: _platformdimension,
//             decoration: InputDecoration(labelText: 'Platform dimension(m)'),
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               if (value == null) {
//                 return "Field can not be Empity";
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: _sideboardheight,
//             decoration: InputDecoration(labelText: 'Sideboard Height (m)'),
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               if (value == null) {
//                 return "Field can not be Empity";
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: _numberoftires,
//             decoration: InputDecoration(labelText: 'Number of tires'),
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               if (value == null) {
//                 return "Field can not be Empity";
//               }
//               return null;
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTractorAttachmentsInputs() {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Radio(
//               value: 'Disc Plough',
//               groupValue: _currentTractorAttachmentsType,
//               onChanged: (value) {
//                 setState(() {
//                   _currentTractorAttachmentsType = value!;
//                 });
//               },
//             ),
//             Text('Disc Plough'),
//             Radio(
//               value: 'Disc Harrow',
//               groupValue: _currentTractorAttachmentsType,
//               onChanged: (value) {
//                 setState(() {
//                   _currentTractorAttachmentsType = value!;
//                 });
//               },
//             ),
//             Text('Disc Harrow '),
//             Radio(
//               value: 'Planter',
//               groupValue: _currentTractorAttachmentsType,
//               onChanged: (value) {
//                 setState(() {
//                   _currentTractorAttachmentsType = value!;
//                 });
//               },
//             ),
//             Text('Planter'),
//           ],
//         ),
//         Row(
//           children: [
//             Radio(
//               value: 'Sprayer',
//               groupValue: _currentTractorAttachmentsType,
//               onChanged: (value) {
//                 setState(() {
//                   _currentTractorAttachmentsType = value!;
//                 });
//               },
//             ),
//             Text('Sprayer'),
//             Radio(
//               value: 'Baler',
//               groupValue: _currentTractorAttachmentsType,
//               onChanged: (value) {
//                 setState(() {
//                   _currentTractorAttachmentsType = value!;
//                 });
//               },
//             ),
//             Text('Baler'),
//             Radio(
//               value: 'Trailer',
//               groupValue: _currentTractorAttachmentsType,
//               onChanged: (value) {
//                 setState(() {
//                   _currentTractorAttachmentsType = value!;
//                 });
//               },
//             ),
//             Text('Trailer'),
//             Radio(
//               value: 'Other',
//               groupValue: _currentTractorAttachmentsType,
//               onChanged: (value) {
//                 setState(() {
//                   _currentTractorAttachmentsType = value!;
//                 });
//               },
//             ),
//             Text('Other '),
//           ],
//         ),
//       ],
//     );
//   }
// }
// // 
// // VerifyServiceProvider