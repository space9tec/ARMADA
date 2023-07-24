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
  const ItemPage({super.key, required this.machine});
  final MachineM machine;

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  _ItemPageState();
  NetworkHandler networkHandler = NetworkHandler();
  final storage = const FlutterSecureStorage();
  final DateFormat _dateFormat = DateFormat("dd MMM yyyy");
  bool get _isBookingButtonEnabled => _startDate != null && _endDate != null;

  String? tok;
  DateTime? _startDate;
  DateTime? _endDate;
  String? tokenbol;
  bool checkedf = false;

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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    String? tokenboll = await TokenManager().getToken();

    setState(() {
      tokenbol = tokenboll;
    });

    var response =
        await networkHandler.get("/api/machinery/${widget.machine.machineId}");

    Map<String, dynamic> output = json.decode(response.body);

    Map<String, dynamic> contractData;

    if (output['contract'] != null) {
      if (mounted) {
        setState(() {
          contractData = output['contract'];
          singlecontract = ContractsModel.fromJson(contractData);
          checkedf = true;
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

  Widget _buildDateSelector(String label, DateTime? date, bool isStartDate) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.39,
      child: InkWell(
        onTap: () {
          _selectDate(context, isStartDate);
        },
        child: InputDecorator(
          decoration: InputDecoration(
              labelText: label,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          child: Row(
            children: <Widget>[
              Text(date == null ? '' : _dateFormat.format(date)),
              const Icon(Icons.calendar_today),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Consumer<ItemNotifire>(builder: (context, value, child) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    leadingWidth: 0,
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back),
                          ),
                          GestureDetector(
                            onTap: null,
                            child: const Icon(Icons.more_horiz),
                          )
                        ],
                      ),
                    ),
                    pinned: true,
                    snap: false,
                    floating: true,
                    // backgroundColor: Colors.transparent,
                    expandedHeight: MediaQuery.of(context).size.height * 0.3,
                    flexibleSpace: FlexibleSpaceBar(
                      background:
                          // Stack(
                          // children: [
                          SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width,
                              // color: Colors.grey.shade300,
                              child: Image.network(
                                "https://armada-server.glitch.me/api/machinery/image/${widget.machine.imageFile}",
                                fit: BoxFit.cover,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   bottom: 5,

                  SliverToBoxAdapter(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(15),
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Typeg: ${widget.machine.type}",
                                  ),
                                  addVerticalSpace(10),
                                  Text(
                                    "Owner : ${widget.machine.manufacturer}",
                                  ),
                                  addVerticalSpace(10),
                                  const Text(
                                    "Price : \$",
                                  ),
                                  addVerticalSpace(10),
                                  const Text(
                                    "Detail :-",
                                  ),
                                  addVerticalSpace(10),
                                  Text(
                                    "Location -  ${widget.machine.region}",
                                  ),
                                  addVerticalSpace(30),
                                  tokenbol != null
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            _buildDateSelector(
                                                'Start Date', _startDate, true),
                                            _buildDateSelector(
                                                'End Date', _endDate, false),
                                          ],
                                        )
                                      : addVerticalSpace(10),
                                  addVerticalSpace(32),
                                  const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text("Other Attachments"),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.24,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(16)),
                                                border: Border.all(
                                                  color: Colors.green,
                                                  width: 1,
                                                ),
                                              ),
                                              padding: const EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.47,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                              margin: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    fit: BoxFit.contain,
                                                    height: 80,
                                                    "assets/images/tracter1.png",
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Text(
                                                    'Item Name',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
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
                                                      color: Colors.yellow),
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
          ? singlecontract.contractId != ""
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.grey,
                    onPressed: () {},
                    elevation: 0,
                    label: singlecontract.status == "accepted"
                        ? Text(
                            "Booked until ${DateFormat('dd MMMM yyyy').format(DateTime.parse(singlecontract.rent_end_time))}",
                            style: const TextStyle(fontSize: 18.0),
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
                            String? userJson = await storage.read(key: 'userm');
                            UserModel usermode =
                                UserModel.fromJson(json.decode(userJson!));

                            Map<String, String> data = {
                              "user_id": usermode.useid,
                              "owner_id": widget.machine.ownerId,
                              "machine_id": widget.machine.machineId,
                              "rent_start_time": _startDate!.toIso8601String(),
                              "rent_end_time": _endDate!.toIso8601String(),
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
                                    fontSize: 16.0, color: Color(0xFF006837)),
                              );
                              print("contract booked");
                              Navigator.pushNamed(context, '/contrat_page');
                            } else {
                              BotToast.showText(
                                text: "Booking Failed: ${response.statusCode}",
                                duration: const Duration(seconds: 2),
                                contentColor: Colors.white,
                                textStyle: const TextStyle(
                                    fontSize: 16.0, color: Color(0xFF006837)),
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
                // splashColor: Colors.red,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
