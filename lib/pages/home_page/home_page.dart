import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:thrifty/bloc/my_home_page_bloc/home_page_bloc.dart';
import 'package:thrifty/pages/full_shop_list_page/shop_list_page.dart';
import 'package:thrifty/pages/transactions_page/transactions_page.dart';
import 'package:thrifty/vars/colors.dart';
import 'package:thrifty/vars/text.dart';

import '../settings_drower/settings_drower.dart';
import 'home_page_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screensize = MediaQuery.of(context).size.height;
    final HomePageBloc _homePageBloc = BlocProvider.of<HomePageBloc>(context);
    List _pages = [
      const TransactionsPage(),
      const HomePageWiget(),
      const FullShopListWiget(),
    ];
    return BlocBuilder<HomePageBloc, HomePagetState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: headcolor2,
        resizeToAvoidBottomInset: false,
        drawer: const SettingsDrawer(),
        appBar: AppBar(
          title: TextButton(
            onPressed: () {},
            onLongPress: () async {
              return showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  final _inputController = TextEditingController(text: '');
                  return AlertDialog(
                    backgroundColor: headcolor2,
                    title: Column(
                      children: [
                        LocaleText(inputNewSumText),
                        TextField(
                          keyboardType: TextInputType.number,
                          focusNode: FocusNode(),
                          controller: _inputController,
                          obscureText: false,
                        )
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: LocaleText(approveText),
                        onPressed: () {
                          try {
                            if (_inputController.text != '') {
                              _homePageBloc.add(EditBudgetSumEvent(
                                  double.parse(_inputController.text),
                                  _homePageBloc.currencyListIndex));
                              Navigator.of(context).pop();
                            } else {
                              Navigator.of(context).pop();
                              _homePageBloc.blankField(context);
                            }
                          } catch (e) {
                            Navigator.of(context).pop();
                            _homePageBloc.blankField(context);
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Row(
              mainAxisAlignment : MainAxisAlignment.spaceBetween,
              children: [
               const SizedBox(),
                Column(
                  crossAxisAlignment : CrossAxisAlignment.end,
                    children: [
                      LocaleText(
                          _homePageBloc.budgetSum < 0 ? negativeBudget : budget,
                          style: TextStyle(
                              color: black, fontSize: screensize * 0.02)),
                      Text(
                          ' ${_homePageBloc.budgetSum} ${_homePageBloc.currencyList[_homePageBloc.currencyListIndex]['currency']}',
                          style:
                              TextStyle(color: black, fontSize: screensize * 0.03, fontWeight: FontWeight.bold)),
                    ]),
              ],
            ),
          ),
        ),
        // ),
        body: _pages.elementAt(_homePageBloc.currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: headcolor2,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.attach_money),
                label: labelBottomNavigashionTransactionlist),
            BottomNavigationBarItem(
                icon: const Icon(Icons.account_balance_wallet),
                label: labelBottomNavigashion),
            BottomNavigationBarItem(
                icon: const Icon(Icons.add_shopping_cart),
                label: labelBottomNavigashionShoplist),
          ],
          currentIndex: _homePageBloc.currentIndex,
          fixedColor: black,
          onTap: (int index) {
            _homePageBloc.add(HomePageEditeCurrentPage(index));
          },
        ),
      );
    });
  }
}
