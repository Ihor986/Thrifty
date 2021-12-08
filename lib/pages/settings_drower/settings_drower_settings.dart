import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:thrifty/bloc/my_home_page_bloc/home_page_bloc.dart';
import 'package:thrifty/vars/colors.dart';
import 'package:thrifty/vars/text.dart';

class SettingsSettings extends StatelessWidget {
  const SettingsSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePagetState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: headcolor2,
        appBar: AppBar(
          title: LocaleText(textSettings),
        ),
        body: Column(
          children: [
            ListTile(
              title: const Text('english'),
              onTap: () {
                context.changeLocale('en');

                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('русский'),
              onTap: () {
                context.changeLocale('ru');

                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    });
  }
}
