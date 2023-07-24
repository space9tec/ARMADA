import 'package:armada/configuration/theme_manager.dart';
import 'package:armada/models/farm.dart';
import 'package:armada/networkhandler.dart';
import 'package:armada/utils/helper_widget.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../farm_screen/edit_farm_screen.dart';

import '../../../provider/item_provider.dart';
import 'farms_screen.dart';

class farmDetail extends StatefulWidget {
  const farmDetail(
      {super.key, required this.farmlist, required this.networkHandler});
  final FarmM farmlist;
  final NetworkHandler networkHandler;

  @override
  State<farmDetail> createState() => _farmDetailState();
}

class _farmDetailState extends State<farmDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => FarmScreen())));
          },
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/edit_farm');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => Editfarm(
                        farmlist: widget.farmlist,
                        networkHandler: widget.networkHandler,
                      )),
                ),
              );
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
                              Map<String, String> data = {
                                "_id": widget.farmlist.farmid,
                              };
                              // var response = await networkHandler.postt(
                              //     "/api/farm/delete", data);
                              var response = await widget.networkHandler.delete(
                                  "/api/farm/${widget.farmlist.farmid}");
                              if (response.statusCode == 200) {
                                Navigator.pushNamed(context, '/farm_screen');

                                BotToast.showText(
                                  text: "Farm deleted",
                                  duration: Duration(seconds: 2),
                                  contentColor: Colors.white,
                                  textStyle: TextStyle(
                                      fontSize: 16.0, color: Color(0xFF006837)),
                                );
                                // Navigator.of(context).pushNamedAndRemoveUntil(
                                //     '/guest', (Route<dynamic> route) => false);
                                // Navigator.of(context).pop();
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
                                    "Farm name: ${widget.farmlist.farmname}",
                                    style: textTheme().displayMedium,
                                  ),
                                  addVerticalSpace(10),
                                  Text(
                                    "Size: ${widget.farmlist.farmsize}",
                                    style: textTheme().displayMedium,
                                  ),
                                  addVerticalSpace(10),
                                  Text(
                                    "Crop type : ${widget.farmlist.croptype}",
                                    style: textTheme().displayMedium,
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
