import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bot_toast/bot_toast.dart';

import '../../../models/model.dart';
import '../../../networkhandler.dart';
import '../../../provider/item_provider.dart';
import '../../../utils/helper_widget.dart';
import '../farm_screen/edit_farm_screen.dart';

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
  void initState() {
    super.initState();
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
                        title: const Text('Confirm Delete'),
                        content: const Text(
                            'Are you sure you want to delete this Farm?'),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            child: const Text('Delete'),
                            onPressed: () async {
                              var response = await widget.networkHandler.delete(
                                  "/api/farm/${widget.farmlist.farmid}");
                              if (response.statusCode == 200) {
                                Navigator.pushNamed(context, '/farm_screen');

                                BotToast.showText(
                                  text: "Farm deleted",
                                  duration: const Duration(seconds: 2),
                                  contentColor: Colors.white,
                                  textStyle: const TextStyle(
                                      fontSize: 16.0, color: Color(0xFF006837)),
                                );
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
                expandedHeight: MediaQuery.of(context).size.height * 0.35,
                flexibleSpace: FlexibleSpaceBar(
                  background: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade300,
                          child: Image.network(
                            "https://armada-server.glitch.me/api/farm/image/${widget.farmlist.imagename}",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Sliv
              SliverToBoxAdapter(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.605,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Farm name: ${widget.farmlist.farmname}",
                          ),
                          addVerticalSpace(10),
                          Text(
                            "Size: ${widget.farmlist.farmsize}",
                          ),
                          addVerticalSpace(10),
                          Text(
                            "Crop type : ${widget.farmlist.croptype}",
                          ),
                          addVerticalSpace(10),
                          Text(
                            "Region : ${widget.farmlist.longtude}",
                          ),
                          addVerticalSpace(10),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
