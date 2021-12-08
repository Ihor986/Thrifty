import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrifty/bloc/my_home_page_bloc/home_page_bloc.dart';
import 'package:thrifty/vars/colors.dart';

class SettingsCounts extends StatelessWidget {
  const SettingsCounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageBloc _homePageBloc = BlocProvider.of<HomePageBloc>(context);
    double screensize = MediaQuery.of(context).size.height;
    String countName = '';
    String currencyName = '';
    return Scaffold(
        backgroundColor: headcolor2,
        appBar: AppBar(
          title: const Text('counts'),
        ),
        body: Column(children: [
          Form(
            child: Column(
              children: [
                SizedBox(height: screensize * 0.02),
                TextField(
                  keyboardType: TextInputType.text,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'enter the count name',
                  ),
                  onChanged: (value) {
                    try {
                      countName = value;
                    } catch (e) {
                      // print('error');
                    }
                  },
                ),
                SizedBox(height: screensize * 0.02),
                TextField(
                  maxLength: 3,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'enter the currency name',
                  ),
                  onChanged: (value) {
                    try {
                      currencyName = value.toUpperCase();
                    } catch (e) {
                      // print('error');
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: screensize * 0.02),
          TextButton(
              onPressed: () {
                if (currencyName != '' && countName != '') {
                  _homePageBloc
                      .add(AddAccountEvent(currencyName, countName, 0.0));
                  Navigator.pop(context, true);
                } else {
                  _homePageBloc.blankField(context);
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.black),
              ))
        ]));
  }
}
