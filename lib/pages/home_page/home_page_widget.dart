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
                        ? Text(
                            '$incomeFromText ${_homePageBloc.transactionsList[index]['category']} ',
                            style: TextStyle(color: green))
                        : Text(
                            '$expenseToText ${_homePageBloc.transactionsList[index]['category']} ',
                            style: TextStyle(color: red)),
                    _homePageBloc.transactionsList[index]['sum'] > 0
                        ? Text(
                            '${_homePageBloc.transactionsList[index]['sum']} ${_homePageBloc.transactionsList[index]['currency']}',
                            style: TextStyle(color: green))
                        : Text(
                            '${_homePageBloc.transactionsList[index]['sum']} ${_homePageBloc.transactionsList[index]['currency']}',
                            style: TextStyle(color: red))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '${_homePageBloc.transactionsList[index]['account']} ${_homePageBloc.transactionsList[index]['date']} ${_homePageBloc.months[int.parse(_homePageBloc.transactionsList[index]['month']) - 1]}',
                        textAlign: TextAlign.start),
                    const SizedBox(),
                  ],
                ),
                SizedBox(height: screensize * 0.015),
              ],
              // mainAxisAlignment: MainAxisAlignment.start,
            ),
          );
        }
        if (_homePageBloc.transactionsList[index].containsKey('sum1')) {
          return Column(
            children: [
              Text(
                '$forwardFromText ${_homePageBloc.transactionsList[index]['account1']} ${_homePageBloc.transactionsList[index]['sum1']} ${_homePageBloc.transactionsList[index]['currency1']}',
                style: TextStyle(color: blue),
              ),
              Text(
                '$forwardToText ${_homePageBloc.transactionsList[index]['account2']} ${_homePageBloc.transactionsList[index]['date']} ${_homePageBloc.months[int.parse(_homePageBloc.transactionsList[index]['month']) - 1]}',
                style: TextStyle(color: blue),
              ),
              SizedBox(height: screensize * 0.015),
            ],
          );
        }
        if (_homePageBloc.transactionsList[index]
            .containsKey('closeTheAccountSum')) {
          return Column(
            children: [
              Center(
                  child: Text(
                deleteAccountTransactionText1,
                style: TextStyle(color: unBought),
              )),
              Center(
                  child: Text(
                '$deleteAccountTransactionText2 ${_homePageBloc.transactionsList[index]['closeTheAccountSum']}',
                style: TextStyle(color: unBought),
              )),
              SizedBox(height: screensize * 0.015),
            ],
          );
        }
      }

      _transactionWidget(int index) {
        if (_homePageBloc.transactionsList[index].containsKey('sum')) {
          return <Widget>[
            TextButton(
              child: Text(editeText),
              onPressed: () async {
                _homePageBloc.editeTransactionIndex = index;
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/EditeTransactionPage');
              },
            ),
            TextButton(
              child: Text(deleteText),
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
              child: Text(editeText),
              onPressed: () async {
                _homePageBloc.editeTransactionIndex = index;
                // EditeForwardTransaction(index);
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/EditeForwardTransactionPage');
              },
            ),
            TextButton(
              child: Text(deleteText),
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
              child: Text(deleteText),
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
          padding: EdgeInsets.only(top: screensize * 0.01),
          child: Container(
            color: headcolor2,
            height: screensize * 0.07,
            child: Center(
              child: Column(
                children: [
                  LocaleText(
                    myMoneyText,
                    style: TextStyle(color: black, fontSize: screensize * 0.03),
                  ),
                  LocaleText(
                    "${_homePageBloc.countsSum} ${_homePageBloc.currencyList[_homePageBloc.currencyListIndex]['currency']}",
                    style: TextStyle(color: black, fontSize: screensize * 0.02),
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
            height: screensize * 0.5,
            child: Container(
              color: headcolor2,
              child: ListView.builder(
                itemCount: _homePageBloc.transactionsList.length,
                itemBuilder: (_, index) => Container(
                  color: index % 2 == 0 ? headcolor2 : headcolor2,
                  child: GestureDetector(
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
                    child: _transactionTextWidget(index),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: screensize * 0.6),
          child: Container(
            height: screensize * 0.1,
            color: headcolor2,
            child: Row(
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          Navigator.pushNamed(context, '/EnterIncomesPage');
                        }),
                  ),
                  Center(
                    child: IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.pushNamed(context, '/EnterForwardPage');
                        }),
                  ),
                  Center(
                    child: IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          Navigator.pushNamed(context, '/EnterTheExpensePage');
                        }),
                  ),
                ]),
          ),
        ),
        DraggableScrollableSheet(
            initialChildSize: 0.1,
            maxChildSize: 0.88,
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
                      padding: const EdgeInsets.only(top: 20),
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
