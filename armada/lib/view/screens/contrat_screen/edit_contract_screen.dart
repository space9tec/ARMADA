import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bot_toast/bot_toast.dart';

import '../../../models/model.dart';
import '../../../networkhandler.dart';
import '../../../provider/provider.dart';
import '../../../utils/helper_widget.dart';
import '../screens.dart';

class EditContract extends StatefulWidget {
  const EditContract({super.key, required this.contractsModel});
  final ContractsModel contractsModel;

  @override
  State<EditContract> createState() => _EditContractState();
}

class _EditContractState extends State<EditContract> {
  NetworkHandler networkHandler = NetworkHandler();
  final storage = const FlutterSecureStorage();
  ContractsModel? contractsmodelfetch;

  DateTime? _startDate;
  DateTime? _endDate;
  bool get _isBookingButtonEnabled => _startDate != null && _endDate != null;
  final DateFormat _dateFormat = DateFormat("dd MMM yyyy");
  bool checkedf = false;
  String? tokenbol;
  String? tok;

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.parse(widget.contractsModel.rent_start_time);
    _endDate = DateTime.parse(widget.contractsModel.rent_end_time);
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Consumer<ItemNotifire>(
              builder: (context, value, child) {
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
                      expandedHeight: MediaQuery.of(context).size.height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            Positioned(
                              bottom: 5,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Type: ${widget.contractsModel.machineId}",
                                            ),
                                            addVerticalSpace(10),
                                            const Text(
                                              "Owner : eyu",
                                            ),
                                            addVerticalSpace(10),
                                            const Text(
                                              "Detail :-",
                                            ),
                                            addVerticalSpace(10),
                                            const Text(
                                              "Location -  Hareri",
                                            ),
                                            addVerticalSpace(30),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                _buildDateSelector('Start Date',
                                                    _startDate, true),
                                                _buildDateSelector('End Date',
                                                    _endDate, false),
                                              ],
                                            ),
                                            addVerticalSpace(32),
                                            const Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text("Other Attachments"),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.24,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: 5,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Stack(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          16)),
                                                          border: Border.all(
                                                            color: Colors.green,
                                                            width: 1,
                                                          ),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.47,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Image.asset(
                                                              fit: BoxFit
                                                                  .contain,
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
                                                                    FontWeight
                                                                        .bold,
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
                                                                color: Colors
                                                                    .yellow),
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
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
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
                          ],
                        ),
                      ),
                    ),
                    // SliverPadding(padding: )
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.70,
        child: FloatingActionButton.extended(
          backgroundColor: _isBookingButtonEnabled
              ? Theme.of(context).primaryColor
              : Colors.grey,
          onPressed: () async {
            Map<String, String> data = {
              "rent_start_time": _startDate!.toIso8601String(),
              "rent_end_time": _endDate!.toIso8601String(),
            };
            var response = await networkHandler.put(
                "/api/contracts/${widget.contractsModel.contractId}", data);

            if (response.statusCode == 200 || response.statusCode == 201) {
              Map<String, dynamic> output = json.decode(response.body);

              Map<String, dynamic> farmData = output;

              // Create UserModel instance using the user data
              ContractsModel machinem = ContractsModel.fromJson(farmData);

              setState(() {
                contractsmodelfetch = machinem;
              });
              BotToast.showText(
                text: "Contract Update",
                duration: const Duration(seconds: 2),
                contentColor: Colors.white,
                textStyle:
                    const TextStyle(fontSize: 16.0, color: Color(0xFF006837)),
              );
              print("contract Update");

              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ContractDetailPage(
                    contractlist: contractsmodelfetch!,
                  );
                },
              ));
            } else {
              BotToast.showText(
                text: "Booking Failed: ${response.statusCode}",
                duration: const Duration(seconds: 2),
                contentColor: Colors.white,
                textStyle:
                    const TextStyle(fontSize: 16.0, color: Color(0xFF006837)),
              );
              print("faild");
              print(response.body.toString());
            }
          },
          elevation: 0,
          label: const Text(
            "UPDATE",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
