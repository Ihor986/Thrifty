import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:thrifty/vars/colors.dart';
import 'package:thrifty/vars/text.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({Key? key}) : super(key: key);

  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        Card(
          color: headcolor,
          child: Column(
            children: const [
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
        ListTile(
            title: TextButton(
          child: LocaleText(
            textSettingsCounts,
            style: TextStyle(
              color: black,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/SettingsCountsHead');
          },
        )),
        const Divider(),
        ListTile(
            title: TextButton(
          child: LocaleText(
            textSettingsBudget,
            style: TextStyle(
              color: black,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/SettingsBudget');
          },
        )),
        const Divider(),
        ListTile(
            title: TextButton(
          child: LocaleText(
            textSettingShopList,
            style: TextStyle(
              color: black,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/SettingsShopList');
          },
        )),
        const Divider(),
        ListTile(
            title: TextButton(
          child: LocaleText(
            textSettings,
            style: TextStyle(
              color: black,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/SettingsSettings');
          },
        )),
      ],
    ));
  }
}
