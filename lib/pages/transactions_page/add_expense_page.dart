import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:thrifty/bloc/my_home_page_bloc/home_page_bloc.dart';
import 'package:thrifty/vars/colors.dart';
import 'package:thrifty/vars/text.dart';

class EnterTheExpensePage extends StatelessWidget {
  const EnterTheExpensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageBloc _homePageBloc = BlocProvider.of<HomePageBloc>(context);
    double screensize = MediaQuery.of(context).size.height;

    return BlocBuilder<HomePageBloc, HomePagetState>(builder: (context, state) {
      return Scaffold(
          backgroundColor: headcolor2,
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LocaleText("transaction"),
                IconButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2099))
                          .then((date) {
                        _homePageBloc.transactionDate = date!;
                      });
                    },
                    icon: const Icon(Icons.calendar_today_outlined))
              ],
            ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onSubmitted: (value) {
                    if (_homePageBloc.transactionSum != 0) {
                      _homePageBloc.add(AddTransactionEvent(
                          _homePageBloc.currencyList.indexWhere((element) =>
                              element['currency'] ==
                              _homePageBloc.countsList[_homePageBloc
                                  .indexToSelectAccount]['currency']),
                          0 - _homePageBloc.transactionSum,
                          _homePageBloc.countsList[
                              _homePageBloc.indexToSelectAccount]['currency'],
                          _homePageBloc.expensCategorys[
                              _homePageBloc.indexToSelectExpenseCategory],
                          _homePageBloc.countsList[
                              _homePageBloc.indexToSelectAccount]['name']));
                      Navigator.pop(context, true);
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
                  ],
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'enter the sum',
                  ),
                  onChanged: (value) {
                    try {
                      _homePageBloc.transactionSum = double.parse(value);
                    } catch (e) {
                      //   print('error');
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: headcolor2,
                child: TextButton(
                  onPressed: () async {
                    return showDialog(
                      context: context,
                      barrierDismissible: true, // user must tap button!
                      builder: (BuildContext context) {
                        final _inputController =
                            TextEditingController(text: '');
                        return AlertDialog(
                          backgroundColor: headcolor2,
                          scrollable: true,
                          title: LocaleText(selectCategory),
                          actions: <Widget>[
                            TextField(
                              focusNode: FocusNode(),
                              controller: _inputController,
                              obscureText: false,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    color: headcolor2,
                                    height: screensize * 0.2,
                                    width: screensize * 0.2,
                                    child: ListView.builder(
                                        itemCount: _homePageBloc
                                            .expensCategorys.length,
                                        itemBuilder: (_, index) => Container(
                                              alignment: Alignment.center,
                                              child: ListTile(
                                                title: TextButton(
                                                  child: Text(_homePageBloc
                                                              .expensCategorys
                                                              .length >
                                                          index
                                                      ? _homePageBloc
                                                              .expensCategorys[
                                                          index]
                                                      : _homePageBloc
                                                              .expensCategorys[
                                                          index - 1]),
                                                  onPressed: () {
                                                    // setState(() {
                                                    _homePageBloc
                                                                .expensCategorys
                                                                .length >
                                                            index
                                                        ? _homePageBloc
                                                                .indexToSelectExpenseCategory =
                                                            index
                                                        : _homePageBloc
                                                                .indexToSelectExpenseCategory =
                                                            index - 1;
                                                    // }

                                                    // });
                                                    Navigator.of(context).pop();
                                                  },
                                                  onLongPress: () async {
                                                    return showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            backgroundColor:
                                                                headcolor2,
                                                            title: const LocaleText(
                                                                "delete category?"),
                                                            actions: [
                                                              Column(
                                                                children: [
                                                                  TextButton(
                                                                    child: LocaleText(
                                                                        approveText),
                                                                    onPressed:
                                                                        () async {
                                                                      _homePageBloc
                                                                              .indexToDeleteCategory =
                                                                          index;
                                                                      _homePageBloc
                                                                          .add(
                                                                              DeliteExpenseCategory(
                                                                        _homePageBloc
                                                                            .indexToDeleteCategory,
                                                                      ));
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          );
                                                        });
                                                  },
                                                ),
                                              ),
                                            )),
                                  ),
                                  TextButton(
                                      child: LocaleText(selectNewCategory),
                                      onPressed: () {
                                        _homePageBloc.add(
                                            OnsubmitedChangeExpensCategorys(
                                                _inputController.text));

                                        Navigator.of(context).pop();
                                      }),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LocaleText(" category is"),
                      Text(
                          ' "${_homePageBloc.expensCategorys[_homePageBloc.indexToSelectExpenseCategory]}"'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: headcolor2,
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LocaleText(fromAccount),
                      Text(
                          ' "${_homePageBloc.countsList[_homePageBloc.indexToSelectAccount]['name']}" ${_homePageBloc.countsList[_homePageBloc.indexToSelectAccount]['currency']}'),
                    ],
                  ),
                  onPressed: () async {
                    return showDialog(
                      context: context,
                      barrierDismissible: true, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: headcolor2,
                          scrollable: true,
                          title: LocaleText(selectAccount),
                          actions: <Widget>[
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    color: headcolor2,
                                    height: screensize * 0.2,
                                    width: screensize * 0.2,
                                    child: ListView.builder(
                                        itemCount:
                                            _homePageBloc.countsList.length,
                                        itemBuilder: (_, index) => Container(
                                              alignment: Alignment.center,
                                              child: ListTile(
                                                title: TextButton(
                                                  child: Text(
                                                      '${_homePageBloc.countsList[index]['name']}'),
                                                  onPressed: () {
                                                    _homePageBloc.add(
                                                        SelectAccountEvent(
                                                            index));
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ),
                                            )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.teal,
                ),
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(20.0),
                child: TextButton(
                  onPressed: () {
                    if (_homePageBloc.transactionSum != 0) {
                      _homePageBloc.add(AddTransactionEvent(
                          _homePageBloc.currencyList.indexWhere((element) =>
                              element['currency'] ==
                              _homePageBloc.countsList[_homePageBloc
                                  .indexToSelectAccount]['currency']),
                          0 - _homePageBloc.transactionSum,
                          _homePageBloc.countsList[
                              _homePageBloc.indexToSelectAccount]['currency'],
                          _homePageBloc.expensCategorys[
                              _homePageBloc.indexToSelectExpenseCategory],
                          _homePageBloc.countsList[
                              _homePageBloc.indexToSelectAccount]['name']));
                      Navigator.pop(context, true);
                    } else {
                      _homePageBloc.blankField(context);
                    }
                  },
                  child:
                      const Text('ok', style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ));
    });
  }
}
