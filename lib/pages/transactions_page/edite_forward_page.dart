import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:thrifty/bloc/my_home_page_bloc/home_page_bloc.dart';
import 'package:thrifty/vars/colors.dart';
import 'package:thrifty/vars/text.dart';

class EditeForwardPage extends StatefulWidget {
  const EditeForwardPage({Key? key}) : super(key: key);

  @override
  State<EditeForwardPage> createState() => _EnterForwardPageState();
}

class _EnterForwardPageState extends State<EditeForwardPage> {
  @override
  Widget build(BuildContext context) {
    double screensize = MediaQuery.of(context).size.height;
    final HomePageBloc _homePageBloc = BlocProvider.of<HomePageBloc>(context);
    return BlocBuilder<HomePageBloc, HomePagetState>(builder: (context, state) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: headcolor2,
          appBar: AppBar(
            title: const Text('transaction'),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  // controller: TextEditingController()
                  //   ..text = _homePageBloc.transactionsList[
                  //               _homePageBloc.editeTransactionIndex]['sum1'] >
                  //           0
                  //       ? '${_homePageBloc.transactionsList[_homePageBloc.editeTransactionIndex]['sum1']}'
                  //       : '${0 - _homePageBloc.transactionsList[_homePageBloc.editeTransactionIndex]['sum1']}',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
                  ],
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: _homePageBloc
                        .transactionsList[_homePageBloc.editeTransactionIndex]
                            ['sum1']
                        .toString(),
                  ),
                  onChanged: (value) {
                    try {
                      _homePageBloc.sumFrom = double.parse(value);
                    } catch (e) {
                      // print('error');
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
                    ],
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: _homePageBloc
                          .transactionsList[_homePageBloc.editeTransactionIndex]
                              ['sum2']
                          .toString(),
                    ),
                    onChanged: (value) {
                      try {
                        _homePageBloc.sumTo = double.parse(value);
                      } catch (e) {
                        // print('error');
                      }
                    }),
              ),
              const SizedBox(height: 10),
              Container(
                color: headcolor2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
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
                                            itemBuilder: (_, index) =>
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: ListTile(
                                                    title: TextButton(
                                                      child: Text(
                                                          // 'category'),
                                                          '${_homePageBloc.countsList[index]['name']}'),
                                                      onPressed: () {
                                                        _homePageBloc.add(
                                                            ChangeForvardAccount(
                                                                1, index));
                                                        Navigator.of(context)
                                                            .pop();
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
                      child: Column(
                        children: [
                          LocaleText(fromAccount),
                          Text(
                              ' "${_homePageBloc.countsList[_homePageBloc.indexForwardAccount1]['name']}"'),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
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
                                            itemBuilder: (_, index) =>
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: ListTile(
                                                    title: TextButton(
                                                      child: Text(
                                                          '${_homePageBloc.countsList[index]['name']}'),
                                                      onPressed: () {
                                                        _homePageBloc.add(
                                                            ChangeForvardAccount(
                                                                2, index));
                                                        Navigator.of(context)
                                                            .pop();
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
                      child: Column(
                        children: [
                          LocaleText(toAccount),
                          Text(
                              ' "${_homePageBloc.countsList[_homePageBloc.indexForwardAccount2]['name']}"'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.teal,
                ),
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(20.0),
                child: TextButton(
                  onPressed: () {
                    // print(sumFrom);
                    if (_homePageBloc.sumFrom != 0 &&
                        _homePageBloc.sumTo != 0) {
                      _homePageBloc.add(EditeForwardTransactionEvent(
                          0.0 - _homePageBloc.sumFrom, _homePageBloc.sumTo));
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
