import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:thrifty/bloc/my_home_page_bloc/home_page_bloc.dart';
import 'package:thrifty/vars/colors.dart';
import 'package:thrifty/vars/text.dart';

class SingleTransactionPageWiget extends StatelessWidget {
  const SingleTransactionPageWiget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screensize = MediaQuery.of(context).size.height;
    return BlocBuilder<HomePageBloc, HomePagetState>(builder: (context, state) {
      final HomePageBloc _homePageBloc = BlocProvider.of<HomePageBloc>(context);

      _transactionTextWidget(index) {
        if (_homePageBloc.transactionsList[index]['account'] ==
                _homePageBloc.countsList[_homePageBloc.indexSinglAccount]
                    ['name'] ||
            _homePageBloc.transactionsList[index]['account1'] ==
                _homePageBloc.countsList[_homePageBloc.indexSinglAccount]
                    ['name'] ||
            _homePageBloc.transactionsList[index]['account2'] ==
                _homePageBloc.countsList[_homePageBloc.indexSinglAccount]
                    ['name']) {
          if (_homePageBloc.transactionsList[index].containsKey('sum')) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _homePageBloc.transactionsList[index]['sum'] > 0
                          ? Row(
                              children: [
                                LocaleText(incomeFromText,
                                    style: TextStyle(color: green)),
                                Text(
                                    ' "${_homePageBloc.transactionsList[index]['category']}" ',
                                    style: TextStyle(color: green)),
                              ],
                            )
                          : Row(
                              children: [
                                LocaleText(expenseToText,
                                    style: TextStyle(color: red)),
                                Text(
                                    ' "${_homePageBloc.transactionsList[index]['category']}" ',
                                    style: TextStyle(color: red)),
                              ],
                            ),
                      _homePageBloc.transactionsList[index]['sum'] > 0
                          ? Text(
                              '${_homePageBloc.transactionsList[index]['sum']} ${_homePageBloc.transactionsList[index]['currency']}',
                              style: TextStyle(color: green))
                          : Text(
                              '${_homePageBloc.transactionsList[index]['sum']} ${_homePageBloc.transactionsList[index]['currency']}',
                              style: TextStyle(color: red))
                    ],
                  ),
                  SizedBox(height: screensize * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                              '${_homePageBloc.transactionsList[index]['date']}'),
                          LocaleText(_homePageBloc.months[int.parse(
                                  _homePageBloc.transactionsList[index]
                                      ['month']) -
                              1]),
                        ],
                      ),
                      Text(
                          '${_homePageBloc.transactionsList[index]['account']}',
                          textAlign: TextAlign.start),
                    ],
                  ),
                  SizedBox(height: screensize * 0.015),
                ],
              ),
            );
          }
          if (_homePageBloc.transactionsList[index].containsKey('sum1')) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          LocaleText(
                            forwardFromText,
                            style: TextStyle(color: blue),
                          ),
                          Text(
                            ' ' +
                                _homePageBloc.transactionsList[index]
                                    ['account1'] +
                                ' ',
                            style: TextStyle(color: blue),
                          ),
                        ],
                      ),
                      Text(
                        '  ${_homePageBloc.transactionsList[index]['sum2']} ${_homePageBloc.transactionsList[index]['currency2']}',
                        style: TextStyle(color: blue),
                      ),
                    ],
                  ),
                  SizedBox(height: screensize * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            _homePageBloc.transactionsList[index]['date'],
                          ),
                          LocaleText(
                            _homePageBloc.months[int.parse(_homePageBloc
                                    .transactionsList[index]['month']) -
                                1],
                          ),
                        ],
                      ),
                      Text(
                        _homePageBloc.transactionsList[index]['account2'],
                      ),
                    ],
                  ),
                  SizedBox(height: screensize * 0.015),
                ],
              ),
            );
          }
          if (_homePageBloc.transactionsList[index]
              .containsKey('closeTheAccountSum')) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LocaleText(
                        deleteAccountTransactionText1,
                        style: TextStyle(color: unBought),
                      ),
                      Text(
                        '${0 - _homePageBloc.transactionsList[index]['closeTheAccountSum']} ${_homePageBloc.transactionsList[index]['currency']}',
                        style: TextStyle(color: unBought),
                      ),
                    ],
                  )),
                  SizedBox(height: screensize * 0.01),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            _homePageBloc.transactionsList[index]['date'],
                            style: TextStyle(color: unBought),
                          ),
                          LocaleText(
                            _homePageBloc.months[int.parse(_homePageBloc
                                    .transactionsList[index]['month']) -
                                1],
                            style: TextStyle(color: unBought),
                          ),
                        ],
                      ),
                      Text(
                        _homePageBloc.transactionsList[index]['account'],
                        style: TextStyle(color: unBought),
                      )
                    ],
                  )),
                  SizedBox(height: screensize * 0.015),
                ],
              ),
            );
          }
        }
      }

      return Scaffold(
          backgroundColor: headcolor2,
          appBar: AppBar(
            title: Text(
                '${_homePageBloc.countsList[_homePageBloc.indexSinglAccount]['name']}'),
          ),
          body: Stack(children: [
            Padding(
              padding: EdgeInsets.only(top: screensize * 0.01),
              child: Container(
                color: headcolor2,
                height: screensize * 0.07,
                child: Center(
                  child: Column(
                    children: [
                      LocaleText(
                        myMoneyText,
                        style: TextStyle(
                            color: black, fontSize: screensize * 0.03),
                      ),
                      Text(
                        '${double.parse(_homePageBloc.countsList[_homePageBloc.indexSinglAccount]['sum'].toStringAsFixed(2))} ${_homePageBloc.countsList[_homePageBloc.indexSinglAccount]['currency']}',
                        style: TextStyle(
                            color: black, fontSize: screensize * 0.02),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screensize * 0.08),
              child: Container(
                color: headcolor2,
                height: screensize * 0.04,
                child: Center(
                  child: LocaleText(
                    transactions,
                    style: TextStyle(color: black, fontSize: screensize * 0.02),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screensize * 0.12),
              child: Container(
                color: headcolor2,
                height: screensize * 0.68,
                child: ListView.builder(
                  itemCount: _homePageBloc.transactionsList.length,
                  itemBuilder: (_, index) => Container(
                    color: headcolor2,
                    child: _transactionTextWidget(index),
                  ),
                ),
              ),
            ),
          ]));
    });
  }
}
