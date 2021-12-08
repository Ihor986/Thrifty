import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:thrifty/bloc/my_home_page_bloc/home_page_bloc.dart';
import 'package:thrifty/vars/colors.dart';
import 'package:thrifty/vars/text.dart';

class FullShopListWiget extends StatelessWidget {
  const FullShopListWiget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePagetState>(builder: (context, state) {
      final HomePageBloc _homePageBloc = BlocProvider.of<HomePageBloc>(context);
      final _inputController = TextEditingController(text: '');
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
                      addNewProductText,
                      style:
                          TextStyle(color: black, fontSize: screensize * 0.03),
                    ),
                  ),
                  Center(
                    child: IconButton(
                        icon: const Icon(Icons.add_outlined),
                        onPressed: () => showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                backgroundColor: headcolor2,
                                title: LocaleText(addNewProductText),
                                content: TextField(
                                    maxLength: 10,
                                    controller: _inputController),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      if (_inputController.text != '') {
                                        _homePageBloc.add(
                                            ShopListAddElementEvent(
                                                _inputController.text));
                                        Navigator.pop(context, 'OK');
                                      } else {
                                        Navigator.pop(context, 'OK');
                                        _homePageBloc.blankField(context);
                                      }
                                    },
                                    child: LocaleText(add),
                                  ),
                                ],
                              ),
                            )),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screensize * 0.1),
            child: Container(
              height: screensize * 0.7,
              color: headcolor2,
              child: ListView.builder(
                  itemCount:
                      _homePageBloc.shopList[_homePageBloc.headShopList].length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            _homePageBloc.add(FullListChangeStatus(_homePageBloc
                                    .shopList[_homePageBloc.headShopList][index]
                                ['id']));
                          },
                          onLongPress: () async {
                            return showDialog(
                              context: context,
                              barrierDismissible: true, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: headcolor2,
                                  title: LocaleText(deleteProductText),
                                  actions: <Widget>[
                                    TextButton(
                                      child: LocaleText(approveText),
                                      onPressed: () {
                                        _homePageBloc.add(
                                            ShopListDeleteElementEvent(index));

                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          // },
                          child: Text(
                            '${_homePageBloc.shopList[_homePageBloc.headShopList][index]['product']}',
                            style: TextStyle(
                                color: _homePageBloc.shopList[_homePageBloc
                                        .headShopList][index]['isBought']
                                    ? bought
                                    : unBought),
                          ),
                        ),
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
