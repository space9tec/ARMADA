import 'package:armada/configuration/theme_manager.dart';
import 'package:armada/provider/item_provider.dart';
import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ItemPage extends StatefulWidget {
  static const String routeName = '/itemPage';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return const ItemPage();
      },
    );
  }

  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  // final PageController pageController = PageController();
  DateTime? _startDate;
  DateTime? _endDate;
  bool get _isBookingButtonEnabled => _startDate != null && _endDate != null;
  final DateFormat _dateFormat = DateFormat("dd MMM yyyy");
  void _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
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
  // void _showDatePicker(BuildContext context) async {
  //   final picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2100),
  //   );

  //   if (picked != null) {
  //     setState(() {
  //       if (_startDate == null || picked.isBefore(_startDate!)) {
  //         _startDate = picked;
  //       } else {
  //         _endDate = picked;
  //       }
  //     });
  //   }
  // }

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
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(date == null ? '' : _dateFormat.format(date)),
              Icon(Icons.calendar_today),
            ],
          ),
        ),
      ),
    );
  }

  late PageController pageController;

  int activePage = 1;
  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
  }

  List<String> images = [
    "assets/images/tracter1.png",
    "assets/images/tracter2.png",
    "assets/images/tracter3.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
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
                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery.of(context).size.height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.grey.shade300,
                                    child: Image.asset(
                                      fit: BoxFit.contain,
                                      height: 100,
                                      "assets/images/tracter1.png",
                                    ),
                                  ),
                                  Positioned(
                                    top: MediaQuery.of(context).size.height *
                                        0.04,
                                    right: 20,
                                    child: const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          height: 60,
                                          width: 100,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                          right: 10,
                                          child: CircleAvatar(
                                            radius: 130,
                                            backgroundColor: Colors.green,
                                            child: Icon(Icons.send,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Tracter",
                                              style: textTheme().displayMedium,
                                            ),
                                            addVerticalSpace(10),
                                            Text(
                                              "Owner :",
                                              style: textTheme().displayMedium,
                                            ),
                                            addVerticalSpace(10),
                                            Text(
                                              "Price : \$",
                                              style: textTheme().displayMedium,
                                            ),
                                            addVerticalSpace(10),
                                            Text(
                                              "Detail :-",
                                              style: textTheme().displayMedium,
                                            ),
                                            addVerticalSpace(10),
                                            Text(
                                              "Location - ",
                                              style: textTheme().displayMedium,
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
                                            // Text(
                                            //   'Select start and end dates:',
                                            //   style: TextStyle(fontSize: 16),
                                            // ),
                                            // SizedBox(height: 8),
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.spaceEvenly,
                                            //   children: [
                                            //     Text(
                                            //       _startDate == null
                                            //           ? 'Select start date'
                                            //           : DateFormat('yyyy-MM-dd')
                                            //               .format(_startDate!),
                                            //       style: TextStyle(fontSize: 16),
                                            //     ),
                                            //     Text(
                                            //       _endDate == null
                                            //           ? 'Select end date'
                                            //           : DateFormat('yyyy-MM-dd')
                                            //               .format(_endDate!),
                                            //       style: TextStyle(fontSize: 16),
                                            //     ),
                                            //   ],
                                            // ),
                                            // SizedBox(height: 16),
                                            // ElevatedButton(
                                            //   onPressed: () =>
                                            //       _showDatePicker(context),
                                            //   child: Text('Select Dates'),
                                            // ),
                                            // SizedBox(height: 16),
                                            // AbsorbPointer(
                                            //   absorbing: !_isBookingButtonEnabled,
                                            //   child: ElevatedButton(
                                            //     onPressed: () {},
                                            //     child: Text('Book Machinery'),
                                            //   ),
                                            // ),
                                            SizedBox(height: 32.0),
                                            const Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text("Other Attachments"),
                                            ),
                                            SizedBox(
                                              width: 400,
                                              height: 200,
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
                                                        width: 200,
                                                        height: 200,
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
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.70,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(20.0),
            // ),
            // child: Positioned(
            //   bottom: 100,
            child: FloatingActionButton.extended(
              backgroundColor: _isBookingButtonEnabled
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
              onPressed: _isBookingButtonEnabled ? () {} : null,
              elevation: 0,
              label: const Text(
                "BOOK NOW",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            // ),
          ),
          // SizedBox(
          //   // width: MediaQuery.of(context).size.width * 0.70,
          //   // decoration: BoxDecoration(
          //   //   borderRadius: BorderRadius.circular(20.0),
          //   // ),
          //   // child: Positioned(
          //   //   bottom: 100,
          //   child: FloatingActionButton(
          //     backgroundColor: _isBookingButtonEnabled
          //         ? Theme.of(context).primaryColor
          //         : Colors.grey,
          //     onPressed: _isBookingButtonEnabled ? () {} : null,
          //     elevation: 0,
          //     child: Icon(Icons.message),
          //   ),
          // ),
          // ),
        ],
      ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
