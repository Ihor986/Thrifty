import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:thrifty/bloc/my_home_page_bloc/home_page_bloc.dart';
import 'package:thrifty/vars/colors.dart';
import 'package:thrifty/vars/text.dart';

class SettingsShopList extends StatelessWidget {
  const SettingsShopList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageBloc _homePageBloc = BlocProvider.of<HomePageBloc>(context);
    double screensize = MediaQuery.of(context).size.height;
    Color getColor(Set<MaterialState> states) {
      // const Set<MaterialState> interactiveStates = <MaterialState>{
      //   MaterialState.pressed,
      //   MaterialState.hovered,
      //   MaterialState.focused,
      // };
      return Colors.teal;
    }

    return BlocBuilder<HomePageBloc, HomePagetState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: headcolor2,
        appBar: AppBar(
          title: LocaleText(textSettingShopList),
        ),
        body: Container(
          color: headcolor2,
          child: ListView.builder(
              itemCount: _homePageBloc.shopList.length,
              itemBuilder: (context, index) {
                bool isChecked = _homePageBloc.headShopList ==
                    '${_homePageBloc.shopList.keys.toList()[index]}';
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onLongPress: () async {
                              if (_homePageBloc.shopList.length > 1) {
                                return showDialog(
                                  context: context,
                                  barrierDismissible:
                                      true, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(deleteShopListText),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(approveText),
                                          onPressed: () async {
                                            _homePageBloc.add(
                                                DeleteShopListEvent(
                                                    _homePageBloc.shopList.keys
                                                        .toList()[index]));
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Text(
                                '${_homePageBloc.shopList.keys.toList()[index]}'),
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            value: isChecked,
                            onChanged: (bool? value) {
                              _homePageBloc.add(ChangeHeadShopListEvent(
                                  '${_homePageBloc.shopList.keys.toList()[index]}'));
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: screensize * 0.05)
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  final _inputController = TextEditingController(text: '');
                  return AlertDialog(
                      backgroundColor: headcolor2,
                      scrollable: true,
                      title: const Text('input new shoplist name'),
                      actions: <Widget>[
                        TextField(
                          focusNode: FocusNode(),
                          controller: _inputController,
                          obscureText: false,
                        ),
                        TextButton(
                          child: const Text('Approve'),
                          onPressed: () async {
                            if (_inputController.text != '') {
                              _homePageBloc.add(
                                  AddNewShopListEvent(_inputController.text));
                              Navigator.of(context).pop();
                            }
                            Navigator.of(context).pop();
                            _homePageBloc.blankField(context);
                          },
                        ),
                      ]);
                });
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
