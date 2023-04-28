import 'package:armada/utils/helper_widget.dart';
import 'package:armada/view/widgets/appBar.dart';
import 'package:flutter/material.dart';

class Main_Screen extends StatefulWidget {
  static const String routeName = '/main_service';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return const Main_Screen();
      },
    );
  }

  const Main_Screen({super.key});

  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Column(
        children: [
          SizedBox(
            height: 230.0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Text(
            "Category",
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              // physics: const BouncingScrollPhysics(
              //     decelerationRate: ScrollDecelerationRate.fast),
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast),
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 120,
                child: Row(
                  children: [
                    Container(
                      width: 250.0,
                      child: ListView(children: [
                        listTileUpperLine(30),
                        const ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: -3),
                          contentPadding: EdgeInsets.zero,
                          title: Text("MACHINERY"),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                          leading: Icon(
                            Icons.account_circle_rounded,
                            size: 25,
                          ),
                        ),
                        listTileUpperLine(30),
                        const ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: -3),
                          contentPadding: EdgeInsets.zero,
                          title: const Text("MACHINERY."),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                          leading: Icon(
                            Icons.account_circle_rounded,
                            size: 25,
                          ),
                        ),
                        listTileUpperLine(30),
                        const ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: -3),
                          contentPadding: EdgeInsets.zero,
                          title: const Text("MACHINERY."),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                          leading: Icon(
                            Icons.account_circle_rounded,
                            size: 25,
                          ),
                        ),
                        listTileUpperLine(30),
                      ]),
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),
                    Container(
                      width: 250.0,
                      child: ListView(children: const [
                        SizedBox(
                          height: 1,
                          child: ColoredBox(color: Colors.black),
                        ),
                        ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: -3),
                          contentPadding: EdgeInsets.zero,
                          title: const Text("MACHINERY"),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                          leading: Icon(
                            Icons.account_circle_rounded,
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          height: 1,
                          width: 70,
                          child: ColoredBox(color: Colors.black),
                        ),
                        ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: -3),
                          contentPadding: EdgeInsets.zero,
                          title: const Text("MACHINERY."),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                          leading: Icon(
                            Icons.account_circle_rounded,
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          height: 1,
                          width: 70,
                          child: ColoredBox(color: Colors.black),
                        ),
                        ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: -3),
                          contentPadding: EdgeInsets.zero,
                          title: const Text("MACHINERY"),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                          leading: Icon(
                            Icons.account_circle_rounded,
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          height: 1,
                          width: 70,
                          child: ColoredBox(color: Colors.black),
                        ),
                      ]),
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),
                    Container(
                      width: 250.0,
                      child: ListView(children: [
                        listTileUpperLine(30),
                        const ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: -3),
                          contentPadding: EdgeInsets.zero,
                          title: Text("MACHINERY"),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                          leading: Icon(
                            Icons.account_circle_rounded,
                            size: 25,
                          ),
                        ),
                        listTileUpperLine(30),
                        const ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: -3),
                          contentPadding: EdgeInsets.zero,
                          title: const Text("MACHINERY."),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                          leading: Icon(
                            Icons.account_circle_rounded,
                            size: 25,
                          ),
                        ),
                        listTileUpperLine(30),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            ),
          ),
        ],
      ),
    );
  }
}
