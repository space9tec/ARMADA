import 'package:armada/configuration/theme_manager.dart';
import 'package:armada/networkhandler.dart';
import 'package:armada/utils/helper_widget.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/machine.dart';
import '../../../provider/item_provider.dart';
import 'edit_machine_screen.dart';

class machineDetail extends StatefulWidget {
  const machineDetail(
      {super.key, required this.machinlist, required this.networkHandler});
  final MachineM machinlist;
  final NetworkHandler networkHandler;

  @override
  State<machineDetail> createState() => _machineDetailState();
}

class _machineDetailState extends State<machineDetail> {
  late CustomTheme customTheme;
  // late TextTheme textTheme;

  @override
  void initState() {
    super.initState();
    // fetchData();
    customTheme = CustomTheme();

    // TODO: implement initState
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
              // Navigator.pushNamed(context, '/edit_farm');
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return EditMacine(
                    machinesingle: widget.machinlist,
                    networkHandler: widget.networkHandler,
                  );
                },
              ));
            },
            icon: const Icon(Icons.edit_sharp),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                icon: const Icon(Icons.delete_outline_sharp,
                    color: Color.fromARGB(255, 1, 82, 32)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text('Confirm Delete'),
                        content:
                            Text('Are you sure you want to delete this Farm?'),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            child: Text('Delete'),
                            onPressed: () async {
                              // Perform the delete operation here
                              // Map<String, String> data = {
                              //   // "phone": machinlist.machineId,
                              //   "id": machinlist.machineId,
                              // };
                              var response = await widget.networkHandler.delete(
                                  "/api/machinery/${widget.machinlist.machineId}");

                              if (response.statusCode == 200) {
                                Navigator.pushNamed(context, '/machie_screen');

                                BotToast.showText(
                                  text: "Machine deleted",
                                  duration: Duration(seconds: 2),
                                  contentColor: Colors.white,
                                  textStyle: TextStyle(
                                      fontSize: 16.0, color: Color(0xFF006837)),
                                );
                                // Navigator.of(context).pushNamedAndRemoveUntil(
                                // Navigator.of(context).pop();
                                //     '/guest', (Route<dynamic> route) => false);
                              } else {
                                print("faild");
                                print(response.body.toString());
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                }),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Consumer<ItemNotifire>(builder: (context, value, child) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                leadingWidth: 0,
                pinned: true,
                snap: false,
                floating: true,
                backgroundColor: Colors.transparent,
                expandedHeight: MediaQuery.of(context).size.height,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.39,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey.shade300,
                              child: Image.asset(
                                fit: BoxFit.contain,
                                height: 100,
                                "assets/images/tracter1.png",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.605,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Farm name: ${widget.machinlist.manufacturer}",
                                    // style: textTheme.displayMedium,
                                  ),
                                  addVerticalSpace(10),
                                  Text(
                                    "Size: ${widget.machinlist.model}",
                                    // style: textTheme.displayMedium,
                                  ),
                                  addVerticalSpace(10),
                                  Text(
                                    "Crop type : ${widget.machinlist.year}",
                                    // style: textTheme.displayMedium,
                                  ),
                                  addVerticalSpace(10),
                                  addVerticalSpace(10),
                                  addVerticalSpace(30),
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
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
