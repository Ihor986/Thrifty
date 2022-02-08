import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:thrifty/bloc/my_home_page_bloc/home_page_bloc.dart';
import 'package:thrifty/vars/colors.dart';
import 'package:thrifty/vars/text.dart';

class SettingsTransactionsList extends StatelessWidget {
  const SettingsTransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageBloc _homePageBloc = BlocProvider.of<HomePageBloc>(context);

    return BlocBuilder<HomePageBloc, HomePagetState>(builder: (context, state) {
      bool isChecked = _homePageBloc.transactionsListLengthLong;
      return Scaffold(
          backgroundColor: headcolor2,
          appBar: AppBar(
            title: LocaleText(transactionListSettingsText),
          ),
          body: SwitchListTile(
            value: isChecked,
            onChanged: (bool newValue) {
              isChecked = newValue;
              _homePageBloc.add(SettingsTransactionsListEvent(isChecked));
            },
            title:
                const LocaleText('Save transactions for the last three months'),
          ));
    });
  }
}
