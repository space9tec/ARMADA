import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class DisplayNotification extends StatefulWidget {
  static const String routeName = '/display_notification';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => DisplayNotification(),
    );
  }

  DisplayNotification({super.key});

  @override
  State<DisplayNotification> createState() => _DisplayNotificationState();
}

class _DisplayNotificationState extends State<DisplayNotification> {
  List newItem = ["liked", "follow"];
  List todayItem = ["follow", "liked", "liked"];

  List oldesItem = ["follow", "follow", "liked", "liked"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: newItem.length,
                itemBuilder: (context, index) {
                  return newItem[index] == "follow"
                      ? CustomFollowNotifcation()
                      : CustomLikedNotifcation();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Today",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: todayItem.length,
                itemBuilder: (context, index) {
                  return todayItem[index] == "follow"
                      ? CustomFollowNotifcation()
                      : CustomLikedNotifcation();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Oldest",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: oldesItem.length,
                itemBuilder: (context, index) {
                  return oldesItem[index] == "follow"
                      ? CustomFollowNotifcation()
                      : CustomLikedNotifcation();
                },
              ),
            ],
          ),
        ),
      ),
      // bottom navbar
      bottomNavigationBar: bottomAppbar(context),
    );
  }
}
