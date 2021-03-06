import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:thrifty/bloc/my_home_page_bloc/home_page_bloc.dart';
import 'package:thrifty/vars/colors.dart';
import 'package:thrifty/vars/text.dart';

class HomePageWiget extends StatelessWidget {
  const HomePageWiget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screensize = MediaQuery.of(context).size.height;
    // double screensizeWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<HomePageBloc, HomePagetState>(builder: (context, state) {
      final HomePageBloc _homePageBloc = BlocProvider.of<HomePageBloc>(context);

      _transactionTextWidget(index) {
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
                                  style: TextStyle(
                                      color: green,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  ' "${_homePageBloc.transactionsList[index]['category']}" ',
                                  style: TextStyle(
                                      color: green,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        : Row(
                            children: [
                              LocaleText(expenseToText,
                                  style: TextStyle(
                                      color: red, fontWeight: FontWeight.bold)),
                              Text(
                                  ' "${_homePageBloc.transactionsList[index]['category']}" ',
                                  style: TextStyle(
                                      color: red, fontWeight: FontWeight.bold)),
                            ],
                          ),
                    _homePageBloc.transactionsList[index]['sum'] > 0
                        ? Text(
                            '${_homePageBloc.transactionsList[index]['sum']} ${_homePageBloc.transactionsList[index]['currency']}',
                            style: TextStyle(
                                color: green, fontWeight: FontWeight.bold))
                        : Text(
                            '${_homePageBloc.transactionsList[index]['sum']} ${_homePageBloc.transactionsList[index]['currency']}',
                            style: TextStyle(
                                color: red, fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(height: screensize * 0.005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                            '${_homePageBloc.transactionsList[index]['date']}'),
                        LocaleText(_homePageBloc.months[int.parse(_homePageBloc
                                .transactionsList[index]['month']) -
                            1]),
                      ],
                    ),
                    Text('${_homePageBloc.transactionsList[index]['account']}',
                        textAlign: TextAlign.start),
                  ],
                ),
                // SizedBox(height: screensize * 0.005),
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
                          style: TextStyle(
                              color: blue, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' ' +
                              _homePageBloc.transactionsList[index]
                                  ['account1'] +
                              ' ',
                          style: TextStyle(
                              color: blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      '  ${_homePageBloc.transactionsList[index]['sum2']} ${_homePageBloc.transactionsList[index]['currency2']}',
                      style:
                          TextStyle(color: blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: screensize * 0.005),
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
                // SizedBox(height: screensize * 0.015),
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
                      style: TextStyle(
                          color: unBought, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${0 - _homePageBloc.transactionsList[index]['closeTheAccountSum']} ${_homePageBloc.transactionsList[index]['currency']}',
                      style: TextStyle(
                          color: unBought, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
                SizedBox(height: screensize * 0.005),
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
                // SizedBox(height: screensize * 0.015),
              ],
            ),
          );
        }
      }

      _transactionWidget(int index) {
        if (_homePageBloc.transactionsList[index].containsKey('sum')) {
          return <Widget>[
            TextButton(
              child: LocaleText(editeText),
              onPressed: () async {
                _homePageBloc.transactionSum =
                    _homePageBloc.transactionsList[index]['sum'] > 0
                        ? _homePageBloc.transactionsList[index]['sum']
                        : 0 - _homePageBloc.transactionsList[index]['sum'];
                _homePageBloc.editeTransactionIndex = index;
                _homePageBloc.transactionDate = DateTime.now();
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/EditeTransactionPage');
              },
            ),
            TextButton(
              child: LocaleText(deleteText),
              onPressed: () async {
                _homePageBloc.add(DeleteTransactionEvent(index));
                Navigator.of(context).pop();
              },
            ),
          ];
        }
        if (_homePageBloc.transactionsList[index].containsKey('sum1')) {
          return <Widget>[
            TextButton(
              child: LocaleText(editeText),
              onPressed: () async {
                _homePageBloc.sumFrom =
                    _homePageBloc.transactionsList[index]['sum1'];
                _homePageBloc.sumTo =
                    _homePageBloc.transactionsList[index]['sum2'];
                _homePageBloc.editeTransactionIndex = index;
                _homePageBloc.transactionDate = DateTime.now();
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/EditeForwardTransactionPage');
              },
            ),
            TextButton(
              child: LocaleText(deleteText),
              onPressed: () async {
                _homePageBloc.add(DeleteForwardTransaction(index));
                Navigator.of(context).pop();
              },
            ),
          ];
        }
        if (_homePageBloc.transactionsList[index]
            .containsKey('closeTheAccountSum')) {
          return <Widget>[
            const SizedBox(width: 10.0),
            TextButton(
              child: LocaleText(deleteText),
              onPressed: () async {
                _homePageBloc.add(DeleteCloseAccountTransaction(index));
                Navigator.of(context).pop();
              },
            ),
          ];
        }
      }

      return Stack(children: [
        Padding(
          padding: EdgeInsets.all(screensize * 0.02),
          child: Container(
            color: headcolor2,
            height: screensize * 0.09,
            // child: Row(
            //       mainAxisAlignment : MainAxisAlignment.spaceBetween,
            //       // crossAxisAlignment : CrossAxisAlignment.end,
            //       children: [
            //       const Icon(Icons.attach_money, size: 20,),
            //         Text(
            //           "${_homePageBloc.countsSum} ${_homePageBloc.currencyList[_homePageBloc.currencyListIndex]['currency']}",
            //           style: TextStyle(color: black, fontSize: screensize * 0.03, fontWeight: FontWeight.bold ),
            //         ),
            //       ],
            //     ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment : CrossAxisAlignment.end,
                  children: [
                    LocaleText(
                      myMoneyText,
                      style:
                          TextStyle(color: black, fontSize: screensize * 0.03),
                    ),
                    const SizedBox(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment : CrossAxisAlignment.end,
                  children: [
                    const SizedBox(),
                    Text(
                      "${_homePageBloc.countsSum} ${_homePageBloc.currencyList[_homePageBloc.currencyListIndex]['currency']}",
                      style: TextStyle(
                          color: black,
                          fontSize: screensize * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.only(top: screensize * 0.06),
        //   child: Container(
        //     color: headcolor2,
        //     height: screensize * 0.04,
        //     child: Center(
        //       child: LocaleText(
        //         transactions,
        //         style: TextStyle(color: black, fontSize: screensize * 0.02),
        //       ),
        //     ),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.only(top: screensize * 0.1),
          child: Container(
            color: headcolor2,
            height: screensize * 0.53,
            child: ListView.builder(
              itemCount: _homePageBloc.transactionsList.length,
              itemBuilder: (_, index) => Container(
                color: index % 2 == 0 ? headcolor2 : headcolor2,
                child: ListTile(
                  onLongPress: () async {
                    return showDialog(
                      context: context,
                      barrierDismissible: true, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: headcolor2,
                          actionsAlignment: MainAxisAlignment.spaceBetween,
                          // title: Text(deleteTransactionText),
                          actions: _transactionWidget(index),
                        );
                      },
                    );
                  },
                  title: _transactionTextWidget(index),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: screensize * 0.57),
          child: Row(
              verticalDirection: VerticalDirection.up,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        _homePageBloc.transactionSum = 0;
                        _homePageBloc.transactionDate = DateTime.now();
                        Navigator.pushNamed(context, '/EnterIncomesPage');
                      }),
                ),
                Center(
                  child: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        _homePageBloc.sumFrom = 0;
                        _homePageBloc.sumTo = 0;
                        _homePageBloc.transactionDate = DateTime.now();
                        Navigator.pushNamed(context, '/EnterForwardPage');
                      }),
                ),
                Center(
                  child: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        _homePageBloc.transactionSum = 0;
                        _homePageBloc.transactionDate = DateTime.now();
                        Navigator.pushNamed(context, '/EnterTheExpensePage');
                      }),
                ),
              ]),
        ),
        DraggableScrollableSheet(
            initialChildSize: 0.1,
            maxChildSize: 0.87,
            minChildSize: 0.1,
            builder: (context, index) {
              return Container(
                child: Stack(children: [
                  ListTile(
                      title: LocaleText(
                    shoplist,
                    style: TextStyle(color: white),
                  )),
                  ListView.builder(
                      padding: EdgeInsets.only(top: screensize * 0.05),
                      controller: index,
                      itemCount: _homePageBloc
                          .shopList[_homePageBloc.headShopList].length,
                      itemBuilder: (context, index) {
                        int id = _homePageBloc
                            .shopList[_homePageBloc.headShopList][index]["id"];
                        if (_homePageBloc.shopList[_homePageBloc.headShopList]
                            [index]['isBought']) {
                          return Dismissible(
                              child: ListTile(
                                  title: Container(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      child: Text(
                                        '${_homePageBloc.shopList[_homePageBloc.headShopList][index]["product"]}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ))),
                              background: Container(
                                color: Colors.white10,
                              ),
                              key: ValueKey<int>(_homePageBloc
                                      .shopList[_homePageBloc.headShopList]
                                  [index]["id"]),
                              onDismissed: (DismissDirection direction) {
                                _homePageBloc.add(FullListChangeStatus(id));
                              });
                        }
                        return const SizedBox();
                      }),
                ]),
                decoration: BoxDecoration(
                    color: headcolor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
              );
            })
      ]);
    });
  }
}
