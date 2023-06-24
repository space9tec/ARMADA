import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

import '../../../networkhandler.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/service_provider_setting';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => SettingsPage(),
    );
  }

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  NetworkHandler networkHandler = NetworkHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Notifications',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SwitchListTile(
                    title: Text('Push Notifications'),
                    value: true,
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Security',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Appearance',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Account',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Add code to delete account here
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text('Confirm Delete'),
                              content: Text(
                                  'Are you sure you want to delete this Farm?'),
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
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 238, 131, 123)),
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    // Perform the delete operation here
                                    Map<String, String> data = {
                                      "phone": "+251932599064",
                                    };
                                    var response = await networkHandler.postt(
                                        "/api/auth/delete", data);

                                    if (response.statusCode == 200) {
                                      BotToast.showText(
                                        text: "Account deleted",
                                        duration: Duration(seconds: 2),
                                        contentColor: Colors.white,
                                        textStyle: TextStyle(
                                            fontSize: 16.0,
                                            color: Color(0xFF006837)),
                                      );
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil('/guest',
                                              (Route<dynamic> route) => false);
                                    } else {
                                      print("faild");
                                      print(response.body.toString());

                                      setState(() {
                                        // validate = false;
                                        // errorText = output;
                                      });
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 153, 146),
                      ),
                      child: Text(
                        'Delete Account',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
