import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bot_toast/bot_toast.dart';

import '../../../../provider/provider.dart';
import '../../../../utils/helper_widget.dart';
import '../../../../models/model.dart';
import '../../../networkhandler.dart';
import '../../../services/tokenManager.dart';

class ItemPage extends StatefulWidget {
  ItemPage({
    super.key,
    required this.machineid,
    this.contractsModel,
  });
  // final MachineM machine;
  String? machineid;
  ContractsModel? contractsModel;
  // String? machineid;
  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  _ItemPageState();
  MachineM machine = MachineM(
      machineId: "",
      ownerId: "",
      manufacturer: "",
      model: "",
      type: "",
      status: "",
      region: "",
      attachmenttype: "",
      year: null,
      hourmeter: "",
      horsepower: null,
      graintank: null,
      graintypes: "",
      workingcapacity: null,
      requiredpower: null,
      additionalinformation: "",
      imageFile: null);

  NetworkHandler networkHandler = NetworkHandler();
  final storage = const FlutterSecureStorage();
  final DateFormat _dateFormat = DateFormat("dd MMM yyyy");
  bool get _isBookingButtonEnabled => _startDate != null && _endDate != null;
  bool get _isUpdateButtonEnabled =>
      (_startDateUpdated != _startDate || _startDateUpdated != null) &&
      (_endDateUpdated != _endDate || _endDateUpdated != null);

  String? tok;
  DateTime? _startDate;
  DateTime? _endDate;

  DateTime? _startDateUpdated;
  DateTime? _endDateUpdated;
  String? tokenbol;
  bool checkedf = false;
  bool edit = false;

  ContractsModel singlecontract = ContractsModel(
      contractId: "",
      userId: "",
      created_at: "",
      machineId: "",
      ownerId: "",
      rent_end_time: "",
      rent_start_time: "",
      status: "",
      updated_at: "");

  UserModel usermode = const UserModel(
      firstname: "",
      image: "",
      lastname: "",
      password: "",
      phone: "",
      useid: "");

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  bool isthattrue = false;

  void fetchData() async {
    // String? tokenboll = await TokenManager().getToken();
    String? userJson = await storage.read(key: 'userm');

    // setState(() {
    //   // tokenbol = tokenboll;
    //   usermode = UserModel.fromJson(json.decode(userJson!));
    // });
    String? tokenboll = await TokenManager().getToken();

    setState(() {
      tokenbol = tokenboll;
      if (userJson != null) {
        usermode = UserModel.fromJson(json.decode(userJson));
      }
    });

    var response =
        await networkHandler.get("/api/machinery/${widget.machineid}");

    Map<String, dynamic> output = json.decode(response.body);
    print(output);

    Map<String, dynamic> contractData;
    Map<String, dynamic> machineDate;

    if (output['machinery'] != null) {
      if (mounted) {
        setState(() {
          machineDate = output['machinery'];
          contractData = output['contract'];
          singlecontract = ContractsModel.fromJson(contractData);
          machine = MachineM.fromJson(machineDate);

          checkedf = true;
          isthattrue = true;
        });
      }
    } else {
      checkedf = false;
    }
  }

  void _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        if (isStartDate) {
          _startDate = date;
        } else {
          _endDate = date;
        }
      });
    }
  }

  Widget _buildDateSelector(
      String label, DateTime? date, bool contr, bool isStartDate) {
    return
        // SizedBox(
        //   width: MediaQuery.of(context).size.width * 0.39,
        //   child: TextFormField(
        //     readOnly: contr ? true : false, // Make the text field read-only
        //     onTap: () {
        //       _selectDate(context, isStartDate);
        //     },
        //     decoration: InputDecoration(
        //       labelText: label,
        //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        //       suffixIcon: const Icon(Icons.calendar_today),
        //     ),
        //     controller: TextEditingController(
        //       text: date == null ? '' : _dateFormat.format(date),
        //     ),
        //   ),
        // );
        SizedBox(
      width: MediaQuery.of(context).size.width * 0.39,
      child: contr
          ? InkWell(
              onTap: () {
                setState(() {
                  date = null;
                  //
                });
                _selectDate(context, isStartDate);
              },
              child: InputDecorator(
                decoration: InputDecoration(
                    labelText: label,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.calendar_today),
                    addHorizontalSpace(10),
                    Text(date == null ? '' : _dateFormat.format(date)),
                  ],
                ),
              ),
            )
          : InkWell(
              onTap: () {
                _selectDate(context, isStartDate);
              },
              child: InputDecorator(
                decoration: InputDecoration(
                    labelText: label,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.calendar_today),
                    addHorizontalSpace(10),
                    Text(date == null ? '' : _dateFormat.format(date)),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return !isthattrue
        ? Scaffold(
            body: CircularProgressIndicator(),
          )
        : Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SafeArea(
                  child:
                      Consumer<ItemNotifire>(builder: (context, value, child) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          leadingWidth: 0,
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.green.withOpacity(0.3),
                                              blurRadius: 5,
                                              spreadRadius: 1)
                                        ]),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      size: 30,
                                      color: Colors.green,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          pinned: true,
                          snap: false,
                          floating: true,
                          expandedHeight:
                              MediaQuery.of(context).size.height * 0.3,
                          flexibleSpace: FlexibleSpaceBar(
                            background: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.network(
                                      "https://armada-server.glitch.me/api/machinery/image/${machine!.imageFile}",
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45),
                                topRight: Radius.circular(15),
                              ), // Specify your desired border radius here
                            ),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.75,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, bottom: 12),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        addVerticalSpace(15),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  machine!.type,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Text("Model: ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0),
                                                  child: Text(
                                                    machine!.model,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        addVerticalSpace(10),
                                        Container(
                                          color: Colors.black.withOpacity(0.03),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.13,
                                          width: double.infinity,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Center(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(Icons
                                                          .calendar_month_outlined),
                                                      const Text(
                                                        'Year',
                                                      ),
                                                      Text('${machine!.year}'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06,
                                                child: const VerticalDivider(
                                                  color: Colors.grey,
                                                  thickness: 1,
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(Icons
                                                          .energy_savings_leaf_outlined),
                                                      const Text(
                                                        'Horse Power',
                                                      ),
                                                      Text(
                                                          '${machine!.horsepower}'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06,
                                                child: const VerticalDivider(
                                                  color: Colors.grey,
                                                  thickness: 1,
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(Icons
                                                          .location_on_outlined),
                                                      const Text(
                                                        'Location',
                                                      ),
                                                      Text(
                                                          '${machine!.region}'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // addVerticalSpace(10),
                                        // InkWell(
                                        //   onTap: () {
                                        //     Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //           builder: ((context) => ItemPage(
                                        //               machine: widget.machine)),
                                        //         ));
                                        //   },
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.symmetric(
                                        //         horizontal: 10, vertical: 5),
                                        //     child: Row(
                                        //       children: [
                                        //         ClipRRect(
                                        //           borderRadius:
                                        //               BorderRadius.circular(2),
                                        //           clipBehavior: Clip.antiAlias,
                                        //           child: Image.asset(
                                        //             "assets/images/farmer_profile.png",
                                        //             height: 32,
                                        //             width: 32,
                                        //             fit: BoxFit.cover,
                                        //           ),
                                        //         ),
                                        //         const SizedBox(
                                        //           width: 10,
                                        //         ),
                                        //         Text(
                                        //           machine!.manufacturer,
                                        //           style: Theme.of(context)
                                        //               .textTheme
                                        //               .bodySmall,
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),

                                        tokenbol != null
                                            ? widget.contractsModel != null ||
                                                    singlecontract.contractId !=
                                                        ""
                                                ? edit
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 28.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            _buildDateSelector(
                                                              'Start Date',
                                                              _startDate,
                                                              false,
                                                              true,
                                                            ),
                                                            _buildDateSelector(
                                                              'End Date',
                                                              _endDate,
                                                              false,
                                                              false,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Container(
                                                        color: Colors.black
                                                            .withOpacity(0.03),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                        width: double.infinity,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Center(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const Text(
                                                                      'Start date',
                                                                    ),
                                                                    widget.contractsModel !=
                                                                            null
                                                                        ? Text(
                                                                            '${_dateFormat.format(DateTime.parse(widget.contractsModel!.rent_start_time))}')
                                                                        : Text(
                                                                            '${_dateFormat.format(DateTime.parse(singlecontract.rent_start_time))}'),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.06,
                                                              child:
                                                                  const VerticalDivider(
                                                                color:
                                                                    Colors.grey,
                                                                thickness: 1,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Center(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const Text(
                                                                      'End date',
                                                                    ),
                                                                    widget.contractsModel !=
                                                                            null
                                                                        ? Text(
                                                                            '${_dateFormat.format(DateTime.parse(widget.contractsModel!.rent_end_time))}')
                                                                        : Text(
                                                                            '${_dateFormat.format(DateTime.parse(singlecontract.rent_end_time))}'),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 28.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        _buildDateSelector(
                                                            'Start Date',
                                                            _startDate,
                                                            false,
                                                            true),
                                                        _buildDateSelector(
                                                            'End Date',
                                                            _endDate,
                                                            false,
                                                            false),
                                                      ],
                                                    ),
                                                  )
                                            : addVerticalSpace(1),
                                        addVerticalSpace(12),
                                        const Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text("Other Attachments"),
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.24,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 5,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  16)),
                                                      border: Border.all(
                                                        color: Colors.green,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.47,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          fit: BoxFit.contain,
                                                          height: 80,
                                                          "assets/images/tracter1.png",
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        const Text(
                                                          'Item Name',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        const Text(
                                                          'Item Description',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Positioned(
                                                    top: 20,
                                                    right: 30,
                                                    child: Column(
                                                      children: [
                                                        Icon(Icons.star,
                                                            color:
                                                                Colors.yellow),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          '4.5',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '100k+',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            Icon(Icons
                                                                .thumb_up_alt_rounded),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // ),
                      ],
                    );
                  }),
                ),
              ),
            ),

            floatingActionButton: tokenbol != null
                ? widget.contractsModel != null
                    ? widget.contractsModel!.ownerId == usermode.useid
                        ? null
                        : singlecontract.contractId != ""
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width * 0.70,
                                child: FloatingActionButton.extended(
                                  backgroundColor: _isUpdateButtonEnabled
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey,
                                  onPressed: _isUpdateButtonEnabled
                                      ? () async {
                                          print(_isUpdateButtonEnabled);
                                          ////////////////////
                                          Map<String, String> data = {
                                            "rent_start_time":
                                                _startDate!.toIso8601String(),
                                            "rent_end_time":
                                                _endDate!.toIso8601String(),
                                          };
                                          var response = await networkHandler.put(
                                              "/api/contracts/${widget.contractsModel?.contractId}",
                                              data);

                                          if (response.statusCode == 200 ||
                                              response.statusCode == 201) {
                                            Map<String, dynamic> output =
                                                json.decode(response.body);

                                            Map<String, dynamic> farmData =
                                                output;

                                            // Create UserModel instance using the user data
                                            ContractsModel machinem =
                                                ContractsModel.fromJson(
                                                    farmData);

                                            setState(() {
                                              widget.contractsModel = machinem;
                                            });
                                            BotToast.showText(
                                              text: "Contract Update",
                                              duration:
                                                  const Duration(seconds: 2),
                                              contentColor: Colors.white,
                                              textStyle: const TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color(0xFF006837)),
                                            );
                                            print("contract Update");

                                            // Navigator.push(context, MaterialPageRoute(
                                            //   builder: (context) {
                                            //     return ContractDetailPage(
                                            //       contractlist: contractsmodelfetch!,
                                            //     );
                                            //   },
                                            // ));
                                            Navigator.pushNamed(
                                                context, "/contrat_page");
                                          } else {
                                            BotToast.showText(
                                              text:
                                                  "Booking Failed: ${response.statusCode}",
                                              duration:
                                                  const Duration(seconds: 2),
                                              contentColor: Colors.white,
                                              textStyle: const TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color(0xFF006837)),
                                            );
                                            print("faild");
                                            print(response.body.toString());
                                          }
                                          ///////////////////////////
                                          print("ready to update");
                                        }
                                      : () {},
                                  elevation: 0,
                                  label: singlecontract.status == "Accepted"
                                      ? Text(
                                          "Booked until ${DateFormat('dd MMMM yyyy').format(DateTime.parse(singlecontract.rent_end_time))}",
                                          style:
                                              const TextStyle(fontSize: 18.0),
                                        )
                                      : edit
                                          ? const Text(
                                              "Update",
                                              style: TextStyle(fontSize: 18.0),
                                            )
                                          : const Text(
                                              "Requested",
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                ),
                              )
                            : SizedBox(
                                width: MediaQuery.of(context).size.width * 0.70,
                                child: FloatingActionButton.extended(
                                  backgroundColor: _isBookingButtonEnabled
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey,
                                  onPressed: _isBookingButtonEnabled
                                      ? () async {
                                          String? userJson =
                                              await storage.read(key: 'userm');
                                          UserModel usermode =
                                              UserModel.fromJson(
                                                  json.decode(userJson!));

                                          Map<String, String> data = {
                                            "user_id": usermode.useid,
                                            "owner_id": machine!.ownerId,
                                            "machine_id": machine!.machineId,
                                            "rent_start_time":
                                                _startDate!.toIso8601String(),
                                            "rent_end_time":
                                                _endDate!.toIso8601String(),
                                          };
                                          var response = await networkHandler
                                              .postt("/api/contracts/", data);

                                          if (response.statusCode == 200 ||
                                              response.statusCode == 201) {
                                            BotToast.showText(
                                              text: "Booking Sent",
                                              duration:
                                                  const Duration(seconds: 2),
                                              contentColor: Colors.white,
                                              textStyle: const TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color(0xFF006837)),
                                            );
                                            print("contract booked");
                                            Navigator.pushNamed(
                                                context, '/contrat_page');
                                          } else {
                                            BotToast.showText(
                                              text:
                                                  "Booking Failed: ${response.statusCode}",
                                              duration:
                                                  const Duration(seconds: 2),
                                              contentColor: Colors.white,
                                              textStyle: const TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color(0xFF006837)),
                                            );
                                            print("faild");
                                            print(response.body.toString());
                                          }
                                        }
                                      : null,
                                  elevation: 0,
                                  label: const Text(
                                    "BOOK NOW",
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              )
                    : singlecontract.contractId != ""
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.70,
                            child: FloatingActionButton.extended(
                              backgroundColor: _isUpdateButtonEnabled
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              onPressed: _isUpdateButtonEnabled
                                  ? () {
                                      print(_isUpdateButtonEnabled);
                                      print("ready to update");
                                    }
                                  : () {},
                              elevation: 0,
                              label: singlecontract.status == "Accepted"
                                  ? Text(
                                      "Booked until ${DateFormat('dd MMMM yyyy').format(DateTime.parse(singlecontract.rent_end_time))}",
                                      style: const TextStyle(fontSize: 18.0),
                                    )
                                  : edit
                                      ? const Text(
                                          "Update",
                                          style: TextStyle(fontSize: 18.0),
                                        )
                                      : const Text(
                                          "Requested",
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width * 0.70,
                            child: FloatingActionButton.extended(
                              backgroundColor: _isBookingButtonEnabled
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              onPressed: _isBookingButtonEnabled
                                  ? () async {
                                      String? userJson =
                                          await storage.read(key: 'userm');
                                      UserModel usermode = UserModel.fromJson(
                                          json.decode(userJson!));

                                      Map<String, String> data = {
                                        "user_id": usermode.useid,
                                        "owner_id": machine!.ownerId,
                                        "machine_id": machine!.machineId,
                                        "rent_start_time":
                                            _startDate!.toIso8601String(),
                                        "rent_end_time":
                                            _endDate!.toIso8601String(),
                                      };
                                      var response = await networkHandler.postt(
                                          "/api/contracts/", data);

                                      if (response.statusCode == 200 ||
                                          response.statusCode == 201) {
                                        BotToast.showText(
                                          text: "Booking Sent",
                                          duration: const Duration(seconds: 2),
                                          contentColor: Colors.white,
                                          textStyle: const TextStyle(
                                              fontSize: 16.0,
                                              color: Color(0xFF006837)),
                                        );
                                        print("contract booked");
                                        Navigator.pushNamed(
                                            context, '/contrat_page');
                                      } else {
                                        BotToast.showText(
                                          text:
                                              "Booking Failed: ${response.statusCode}",
                                          duration: const Duration(seconds: 2),
                                          contentColor: Colors.white,
                                          textStyle: const TextStyle(
                                              fontSize: 16.0,
                                              color: Color(0xFF006837)),
                                        );
                                        print("faild");
                                        print(response.body.toString());
                                      }
                                    }
                                  : null,
                              elevation: 0,
                              label: const Text(
                                "BOOK NOW",
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          )
                : SizedBox(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.grey,
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      elevation: 0,
                      label: const Text(
                        "Login to book",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
            // : null,

            floatingActionButtonLocation: (singlecontract.contractId != "" ||
                        widget.contractsModel != null) &&
                    !edit &&
                    singlecontract.status != "Accepted"
                ? CustomFabLocation(0.15, 0.86)
                : CustomFabLocation(0.15, 0.9),
            // singlecontract.contractId != "" &&
            bottomSheet: tokenbol != null
                ? widget.contractsModel != null
                    ? widget.contractsModel!.ownerId == usermode.useid
                        ? Row(
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.496,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    print("object");
                                    Map<String, String> updateData = {
                                      "status": "Accepted",
                                    };
                                    var updateResponse = await networkHandler.put(
                                        "/api/contracts/${widget.contractsModel!.contractId}",
                                        updateData);
                                    if (updateResponse.statusCode == 200 ||
                                        updateResponse.statusCode == 201) {
                                      print("contract status updated");
                                    }

                                    Navigator.pushNamed(
                                        context, '/contrat_page');
                                    // setState(() {
                                    //   print(_isUpdateButtonEnabled);
                                    //   edit = true;
                                    //   _startDate = DateTime.parse(
                                    //       widget.contractsModel!.rent_start_time);
                                    //   _endDate = DateTime.parse(
                                    //       widget.contractsModel!.rent_end_time);
                                    // });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFF006837),
                                    ),
                                  ),
                                  child: const Text(
                                    'Confirm',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              addHorizontalSpace(1),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.496,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: ElevatedButton(
                                  onPressed: edit
                                      ? () {
                                          setState(() {
                                            edit = false;
                                          });
                                        }
                                      : () async {
                                          Map<String, String> updateData = {
                                            "status": "Rejected",
                                          };
                                          var updateResponse =
                                              await networkHandler.put(
                                                  "/api/contracts/${widget.contractsModel!.contractId}",
                                                  updateData);
                                          if (updateResponse.statusCode ==
                                                  200 ||
                                              updateResponse.statusCode ==
                                                  201) {
                                            print("contract status updated");
                                          }

                                          Navigator.pushNamed(
                                              context, '/contrat_page');
                                        },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFF006837),
                                    ),
                                  ),
                                  child: const Text(
                                    'Reject',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ) //
                        : edit || singlecontract.status == "Accepted"
                            ? null
                            : Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.496,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: ElevatedButton(
                                      onPressed: edit
                                          ? () {}
                                          : () {
                                              setState(() {
                                                print(_isUpdateButtonEnabled);
                                                edit = true;
                                                _startDate = DateTime.parse(
                                                    widget.contractsModel!
                                                        .rent_start_time);
                                                _endDate = DateTime.parse(widget
                                                    .contractsModel!
                                                    .rent_end_time);
                                              });
                                              // Map<String, String> updateData = {
                                              //   "status": "rejected",
                                              // };
                                              // var updateResponse = await networkHandler.put(
                                              //     "/api/contracts/${widget.contractsModel!.contractId}",
                                              //     updateData);
                                              // if (updateResponse.statusCode == 200 ||
                                              //     updateResponse.statusCode == 201) {
                                              //   print("contract status updated");
                                              // }

                                              // Navigator.pushNamed(context, '/contrat_page');
                                            },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          const Color(0xFF006837),
                                        ),
                                      ),
                                      child: const Text(
                                        'Edit',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  addHorizontalSpace(1),
                                  Expanded(
                                    child: SizedBox(
                                      // width: MediaQuery.of(context).size.width * 0.496,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          // Map<String, String> updateData = {
                                          //   "status": "accepted",
                                          // };
                                          // var updateResponse = await networkHandler.put(
                                          //     "/api/contracts/${widget.contractsModel!.contractId}",
                                          //     updateData);

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                // backgroundColor: Colors.white,
                                                title: const Text(
                                                    'Cancel Request'),
                                                content: const Text(
                                                    'Are you sure you want to Cancel this Contract Request?'),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            elevation: 0,
                                                            backgroundColor: Theme
                                                                    .of(context)
                                                                .primaryColor),
                                                    child: const Text('No'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  ElevatedButton(
                                                    child: const Text('Yes'),
                                                    onPressed: () async {
                                                      var response =
                                                          await networkHandler
                                                              .delete(
                                                                  "/api/contracts/${widget.contractsModel?.contractId}");

                                                      if (response.statusCode ==
                                                          200) {
                                                        Navigator.pushNamed(
                                                            context,
                                                            '/contrat_page');

                                                        BotToast.showText(
                                                          text:
                                                              "Request canceled",
                                                          duration:
                                                              const Duration(
                                                                  seconds: 2),
                                                          contentColor:
                                                              Colors.white,
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: Color(
                                                                      0xFF006837)),
                                                        );
                                                      } else {
                                                        print("Faild" +
                                                            response.body
                                                                .toString());
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          // if (updateResponse.statusCode == 200 ||
                                          //     updateResponse.statusCode == 201) {
                                          //   print("contract status updated");
                                          // }

                                          // Navigator.pushNamed(context, '/contrat_page');
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            const Color(0xFF006837),
                                          ),
                                        ),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                    : singlecontract.contractId != ""
                        ? edit || singlecontract.status == "Accepted"
                            ? null
                            : Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.496,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: ElevatedButton(
                                      onPressed: edit
                                          ? () {}
                                          : () {
                                              setState(() {
                                                print(_isUpdateButtonEnabled);
                                                edit = true;
                                                _startDate = DateTime.parse(
                                                    singlecontract
                                                        .rent_start_time);
                                                _endDate = DateTime.parse(
                                                    singlecontract
                                                        .rent_end_time);
                                              });
                                              // Map<String, String> updateData = {
                                              //   "status": "rejected",
                                              // };
                                              // var updateResponse = await networkHandler.put(
                                              //     "/api/contracts/${widget.contractsModel!.contractId}",
                                              //     updateData);
                                              // if (updateResponse.statusCode == 200 ||
                                              //     updateResponse.statusCode == 201) {
                                              //   print("contract status updated");
                                              // }

                                              // Navigator.pushNamed(context, '/contrat_page');
                                            },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          const Color(0xFF006837),
                                        ),
                                      ),
                                      child: const Text(
                                        'Edit',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  addHorizontalSpace(1),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.496,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: ElevatedButton(
                                      onPressed: edit
                                          ? () {
                                              setState(() {
                                                edit = false;
                                              });
                                            }
                                          : () async {
                                              // Map<String, String> updateData = {
                                              //   "status": "accepted",
                                              // };
                                              // var updateResponse = await networkHandler.put(
                                              //     "/api/contracts/${widget.contractsModel!.contractId}",
                                              //     updateData);
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    // backgroundColor: Colors.white,
                                                    title: const Text(
                                                        'Cancel Request'),
                                                    content: const Text(
                                                        'Are you sure you want to Cancel this Contract Request?'),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            elevation: 0,
                                                            backgroundColor: Theme
                                                                    .of(context)
                                                                .primaryColor),
                                                        child: const Text('No'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      ElevatedButton(
                                                        child:
                                                            const Text('Yes'),
                                                        onPressed: () async {
                                                          var response =
                                                              await networkHandler
                                                                  .delete(
                                                                      "/api/contracts/${widget.contractsModel?.contractId}");

                                                          if (response
                                                                  .statusCode ==
                                                              200) {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/contrat_page');

                                                            BotToast.showText(
                                                              text:
                                                                  "Request canceled",
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          2),
                                                              contentColor:
                                                                  Colors.white,
                                                              textStyle: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: Color(
                                                                      0xFF006837)),
                                                            );
                                                          } else {
                                                            print("Faild" +
                                                                response.body
                                                                    .toString());
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );

                                              // if (updateResponse.statusCode == 200 ||
                                              //     updateResponse.statusCode == 201) {
                                              //   print("contract status updated");
                                              // }

                                              // Navigator.pushNamed(context, '/contrat_page');
                                            },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          const Color(0xFF006837),
                                        ),
                                      ),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                        : null
                : null,
          );
  }
}

class CustomFabLocation extends FloatingActionButtonLocation {
  final double x;
  final double y;

  CustomFabLocation(this.x, this.y);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = scaffoldGeometry.scaffoldSize.width * x;
    final double fabY = scaffoldGeometry.scaffoldSize.height * y;
    return Offset(fabX, fabY);
  }
}
