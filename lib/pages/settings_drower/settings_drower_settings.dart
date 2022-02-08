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
      var lang = context.currentLocale;
      return Scaffold(
        backgroundColor: headcolor2,
        appBar: AppBar(
          title: LocaleText(textSettings),
        ),
        body: Column(
          children: [
            ListTile(
              title: Text(
                'English',
                style: TextStyle(
                    color: lang.toString() == 'en' ? unBought : bought),
              ),
              onTap: () {
                context.changeLocale('en');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(
                'Українська',
                style: TextStyle(
                    color: lang.toString() == 'uk' ? unBought : bought),
              ),
              onTap: () {
                context.changeLocale('uk');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(
                'Русский',
                style: TextStyle(
                    color: lang.toString() == 'ru' ? unBought : bought),
              ),
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
