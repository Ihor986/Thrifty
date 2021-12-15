import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:thrifty/bloc/my_home_page_bloc/home_page_bloc.dart';
import 'package:thrifty/vars/colors.dart';
import 'package:thrifty/vars/text.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePagetState>(builder: (context, state) {
      final HomePageBloc _homePageBloc = BlocProvider.of<HomePageBloc>(context);
      double screensize = MediaQuery.of(context).size.height;
      return Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: screensize * 0.01),
            child: Container(
              color: headcolor2,
              height: screensize * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: LocaleText(
                      transactionHeaderText,
                      style:
                          TextStyle(color: black, fontSize: screensize * 0.03),
                    ),
                  ),
                  Center(
                    child: IconButton(
                        icon: const Icon(Icons.add_outlined),
                        onPressed: () {
                          Navigator.pushNamed(context, '/SettingsCounts');
                        }),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screensize * 0.1),
            child: Container(
              height: screensize * 0.65,
              color: headcolor2,
              child: ListView.builder(
                  itemCount: _homePageBloc.countsList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: ListTile(
                            onTap: () {
                              _homePageBloc.indexSinglAccount = index;
                              Navigator.pushNamed(
                                  context, '/SingleTransactionPageWiget');
                            },
                            onLongPress: () async {
                              if (_homePageBloc.countsList.length > 1) {
                                return showDialog(
                                  context: context,
                                  barrierDismissible:
                                      true, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: LocaleText(deleteAccountText),
                                      actions: <Widget>[
                                        TextButton(
                                          child: LocaleText(approveText),
                                          onPressed: () async {
                                            _homePageBloc
                                                .add(DeleteAccountEvent(index));
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${_homePageBloc.countsList[index]['name']}'),
                                Text(
                                    '${double.parse(_homePageBloc.countsList[index]['sum'].toStringAsFixed(2))} ${_homePageBloc.countsList[index]['currency']}'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screensize * 0.05)
                      ],
                    );
                  }),
            ),
          ),
        ],
      );
    });
  }
}
