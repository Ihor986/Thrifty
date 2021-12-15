import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:thrifty/bloc/my_home_page_bloc/home_page_bloc.dart';
import 'package:thrifty/vars/colors.dart';
import 'package:thrifty/vars/text.dart';

class SettingsCountsHead extends StatelessWidget {
  const SettingsCountsHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageBloc _homePageBloc = BlocProvider.of<HomePageBloc>(context);
    double screensize = MediaQuery.of(context).size.height;
    Color getColor(Set<MaterialState> states) {
      return Colors.teal;
    }

    return BlocBuilder<HomePageBloc, HomePagetState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: headcolor2,
        appBar: AppBar(
          title: LocaleText(textSettingsCounts),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: screensize * 0.05, left: 20, right: 20),
          child: Container(
            height: screensize * 0.7,
            color: headcolor2,
            child: ListView.builder(
                itemCount: _homePageBloc.currencyList.length,
                itemBuilder: (context, index) {
                  bool isChecked = _homePageBloc.currencyListIndex == index;
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '${_homePageBloc.currencyList[index]['currency']}'),
                        Row(
                          children: [
                            Text(
                              '${double.parse(_homePageBloc.currencyList[index]['sum'].toStringAsFixed(2))}',

                              // textAlign: TextAlign.end,
                            ),
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: isChecked,
                              onChanged: (bool? value) {
                                _homePageBloc
                                    .add(ChangeCurrencyListIndexEvent(index));
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      );
    });
  }
}
