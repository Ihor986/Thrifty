import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:thrifty/bloc/my_home_page_bloc/home_page_bloc.dart';
import 'package:thrifty/vars/colors.dart';
import 'package:thrifty/vars/text.dart';

class SettingsBudget extends StatelessWidget {
  const SettingsBudget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageBloc _homePageBloc = BlocProvider.of<HomePageBloc>(context);
    double screensize = MediaQuery.of(context).size.height;
    return BlocBuilder<HomePageBloc, HomePagetState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: headcolor2,
        appBar: AppBar(
          title: LocaleText(textSettingsBudget),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            color: headcolor2,
            child: ListView.builder(
                itemCount: _homePageBloc.currencyList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '${_homePageBloc.currencyList[index]['currency']}'),
                            Column(
                              children: [
                                Text(
                                    '${double.parse(_homePageBloc.currencyList[index]['budget'].toStringAsFixed(2))}'),
                                TextButton(
                                  onPressed: () async {
                                    return showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          final _inputController =
                                              TextEditingController(text: '');
                                          return AlertDialog(
                                              backgroundColor: headcolor2,
                                              scrollable: true,
                                              title: const Text(
                                                  'input new budget sum'),
                                              actions: <Widget>[
                                                TextField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  focusNode: FocusNode(),
                                                  controller: _inputController,
                                                  obscureText: false,
                                                ),
                                                TextButton(
                                                  child: const Text('Approve'),
                                                  onPressed: () async {
                                                    try {
                                                      _homePageBloc.add(
                                                          EditBudgetSumEvent(
                                                              double.parse(
                                                                  _inputController
                                                                      .text),
                                                              index));
                                                      Navigator.of(context)
                                                          .pop();
                                                    } catch (e) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      _homePageBloc
                                                          .blankField(context);
                                                    }
                                                  },
                                                ),
                                              ]);
                                        });
                                  },
                                  child: const Text('edite sum'),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screensize * 0.05)
                    ],
                  );
                }),
          ),
        ),
      );
    });
  }
}
