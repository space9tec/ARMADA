import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/service_provider_setting';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => SettingsPage(),
    );
  }

  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationEnabled = false;
  bool _darkModeEnabled = false;
  void initState() {
    super.initState();
    fetchData();
  }

  String? token;
  fetchData() async {
    final storage = new FlutterSecureStorage();
    token = await storage.read(key: 'token');

    setState(() {
      if (token != null) {
        token = "value";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(Icons.done),
        //   ),
        // ],
      ),
      backgroundColor: const Color(0xfff6f6f6),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "General",
                children: [
                  // _CustomListTile(
                  //     title: "Notification",
                  //     icon: Icons.notifications,
                  //     url: "notification"),
                  if (token != null)
                    ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text('Notification Enable'),
                      trailing: Switch(
                        value: _notificationEnabled,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (value) {
                          setState(() {
                            _notificationEnabled = value;
                          });
                        },
                      ),
                    ),
                  ListTile(
                    leading: Icon(Icons.monochrome_photos),
                    title: Text('Dark Mode'),
                    trailing: Switch(
                      activeColor: Colors.black87,
                      value: _darkModeEnabled,
                      onChanged: (value) {
                        setState(() {
                          _darkModeEnabled = value;
                        });
                      },
                    ),
                  ),
                  // _CustomListTile(
                  //   title: "Dark Mode",
                  //   icon: Icons.monochrome_photos,
                  //   url: "h",
                  // ),
                  _CustomListTilelanguage(
                      title: "Language",
                      icon: Icons.language,
                      value: "English"),
                  // const _CustomListTile(
                  //     title: "Security Status", icon: Icons.security),
                ],
              ),
              if (token != null)
                const _SingleSection(
                  title: "Account",
                  children: [
                    _CustomListTile(
                        title: "Change Password",
                        icon: Icons.password,
                        url: "changepassword"),
                    _CustomListTile(
                      title: "Delete Account",
                      icon: Icons.delete,
                      url: "deleteAccount",
                    ),
                  ],
                ),
              const _SingleSection(
                title: "About",
                children: [
                  // _CustomListTile(
                  // title: "Multiple Users", icon: Icons.person_2),
                  // _CustomListTile(title: "Lock Screen", icon: Icons.lock),
                  _CustomListTile(
                    title: "Privecy policy",
                    icon: Icons.display_settings,
                    url: "privecyPolicy",
                  ),
                  _CustomListTile(
                    title: "Terms and Conditions",
                    icon: Icons.audio_file,
                    url: "TermsandConditions",
                  ),
                  // _CustomListTile(title: "Themes", icon: Icons.piano_outlined)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String url;
  // final Widget? trailing;
  const _CustomListTile(
      {Key? key, required this.title, required this.icon, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: Icon(Icons.arrow_forward_ios_rounded),

      // trailing: Container(
      //   width: MediaQuery.of(context).size.width * 0.2,
      //   child: trailing ?? const Icon(Icons.forward, size: 18),
      // ),
      onTap: () {
        Navigator.pushNamed(context, '/${url}');
      },
    );
  }
}

class _CustomListTilelanguage extends StatelessWidget {
  final String title;
  final IconData icon;
  final String value;
  // final Widget? trailing;
  const _CustomListTilelanguage(
      {Key? key, required this.title, required this.icon, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(title),
      leading: Icon(icon),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
      subtitle: Text(value),
      // trailing: Container(
      //   width: MediaQuery.of(context).size.width * 0.2,
      //   child: trailing ?? const Icon(Icons.forward, size: 18),
      // ),
      //  dense: dense,
      // enabled: enabled && isLoading != true,
      // selected: selected,
      // contentPadding: padding,
      // leading: leading,
      // title: title,
      // subtitle: isTwoLine && hideValue != true ? _valueWidget : null,
      // trailing: _trailingWidget,
      // onTap: onTap,
      onTap: () {},
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
