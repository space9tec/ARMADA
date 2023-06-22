import 'package:armada/configuration/theme_manager.dart';
import 'package:armada/models/farm.dart';
import 'package:armada/networkhandler.dart';
import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/item_provider.dart';

class farmDetail extends StatelessWidget {
  const farmDetail(
      {super.key, required this.farmlist, required this.networkHandler});
  final FarmM farmlist;
  final NetworkHandler networkHandler;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/edit_farm');
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
                            onPressed: () {
                              // Perform the delete operation here
                              Navigator.of(context).pop();
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
                // title: Padding(
                //   padding: EdgeInsets.only(bottom: 10),
                //   // child: Row(
                //   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   //   children: [
                //   //     GestureDetector(
                //   //       onTap: () {
                //   //         Navigator.pop(context);
                //   //       },
                //   //       child: const Icon(Icons.arrow_back),
                //   //     ),
                //   //     GestureDetector(
                //   //       onTap: null,
                //   //       child: const Icon(Icons.more_horiz),
                //   //     )
                //   //   ],
                //   // ),
                // ),
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
                                    "Farm name: ${farmlist.farmname}",
                                    style: textTheme().displayMedium,
                                  ),
                                  addVerticalSpace(10),
                                  Text(
                                    "Size: ${farmlist.farmsize}",
                                    style: textTheme().displayMedium,
                                  ),
                                  addVerticalSpace(10),
                                  Text(
                                    "Crop type : ${farmlist.croptype}",
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
