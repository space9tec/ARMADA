import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/themeProvider.dart';
import '../../../services/tokenManager.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/service_provider_setting';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const SettingsPage(),
    );
  }

  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationEnabled = false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String? token;
  fetchData() async {
    token = await TokenManager().getToken();

    setState(() {
      if (token != null) {
        token = "value";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      // backgroundColor: const Color(0xfff6f6f6),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "General",
                children: [
                  if (token != null)
                    ListTile(
                      leading: const Icon(Icons.notifications),
                      title: const Text('Notification Enable'),
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
                    leading: const Icon(Icons.monochrome_photos),
                    title: const Text('Dark Mode'),
                    trailing: Switch(
                      activeColor: const Color.fromRGBO(0, 0, 0, 0.867),
                      // value: _darkModeEnabled,
                      value: themeProvider.currentThemeMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                        // setState(() {
                        //   _darkModeEnabled = value;
                        // });
                        print(themeProvider.currentThemeMode);
                      },
                    ),
                  ),
                  const _CustomListTilelanguage(
                      title: "Language",
                      icon: Icons.language,
                      value: "English"),
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

  const _CustomListTile(
      {Key? key, required this.title, required this.icon, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () {
        Navigator.pushNamed(context, '/$url');
      },
    );
  }
}

class _CustomListTilelanguage extends StatelessWidget {
  final String title;
  final IconData icon;
  final String value;
  const _CustomListTilelanguage(
      {Key? key, required this.title, required this.icon, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(title),
      leading: Icon(icon),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      subtitle: Text(value),
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
          // color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
