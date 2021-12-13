import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:thrifty/vars/colors.dart';
part 'home_page_events.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePagetState> {
  List<String> lang = ['eng', 'ru'];
  int indexLang = 0;
  int currentIndex = 1;
  List<String> months = [
    'January ',
    'February ',
    'March ',
    'April ',
    'May ',
    'June ',
    'July ',
    'August ',
    'September ',
    'October ',
    'November ',
    'December '
  ];
  List transactionsList = [];
  DateTime transactionDate = DateTime.now();
  double transactionSum = 0;
  double sumFrom = 0.0;
  double sumTo = 0.0;
  List countsList = [
    {
      'currency': 'USD',
      'name': 'purse',
      'id': 'IdpurseUSD',
      'sum': 0.0,
    },
  ];
  int indexSinglAccount = 0;
  int indexToSelectAccount = 0; //
  int countsListIndex = 0;
  int indexForwardAccount1 = 0;
  int indexForwardAccount2 = 0;
  int editeTransactionIndex = 0;
  Map shopList = {
    'My list': [
      {
        'product': 'carrot',
        'id': DateTime.now().millisecondsSinceEpoch,
        'isBought': true
      },
    ],
  };
  String headShopList = 'My list';
  List currencyList = [
    {
      'id': DateTime.now().millisecondsSinceEpoch,
      'currency': 'USD',
      'sum': 0.0,
      'budget': 0.0,
    }
  ];
  List<String> incomeCategorys = ['profit', 'salary'];
  int indexToSelectIncomeCategory = 0;
  List<String> expensCategorys = ['relax', 'eat'];
  int indexToSelectExpenseCategory = 0;
  int indexToDeleteCategory = 0;
  int currencyListIndex = 0;
  double budgetSum = 0;
  double countsSum = 0;

  HomePageBloc(HomePagetState initialState) : super(initialState);

  @override
  Stream<HomePagetState> mapEventToState(
    HomePageEvent event,
  ) async* {
    if (event is HomePageInitialstate) {
      await _initial();
      yield HomePageActiveState();
    }
    if (event is HomePageEditeCurrentPage) {
      await _changeCurrentPage(event.index);
      yield HomePageActiveState();
    }
    if (event is AddTransactionEvent) {
      await _addTransaction(event.sum, event.currency, event.category,
          event.account, event.currencyListIndex);
      yield HomePageActiveState();
    }
    if (event is DeleteTransactionEvent) {
      await _deleteTransaction(event.index);
      yield HomePageActiveState();
    }
    if (event is DeliteExpenseCategory) {
      await _deleteExpenseCategory(event.index);
      yield HomePageActiveState();
    }
    if (event is DeliteIncomeCategory) {
      await _deliteIncomeCategory(event.index);
      yield HomePageActiveState();
    }

    if (event is OnsubmitedChangeExpensCategorys) {
      await _onsubmitedChangeExpensCategorys(event.value);
      yield HomePageActiveState();
    }
    if (event is OnsubmitedChangeIncomeCategorys) {
      await _onsubmitedChangeIncomeCategorys(event.value);
      yield HomePageActiveState();
    }
    if (event is AddAccountEvent) {
      await _addAccount(event.currency, event.name, event.sum);
      yield HomePageActiveState();
    }
    if (event is FullListChangeStatus) {
      await _changeStatusShopListElement(event.value);
      yield HomePageActiveState();
    }
    if (event is ShopListAddElementEvent) {
      await _shopListAdd(event.value);
      yield HomePageActiveState();
    }
    if (event is ShopListDeleteElementEvent) {
      await _deleteShopListElement(event.value);
      yield HomePageActiveState();
    }
    if (event is EditBudgetSumEvent) {
      await _editBudgetSum(event.value, event.index);
      yield HomePageActiveState();
    }
    if (event is SelectAccountEvent) {
      await _selectAccount(event.index);
      yield HomePageActiveState();
    }
    if (event is ChangeHeadShopListEvent) {
      await _changeHeadShopList(event.value);
      yield HomePageActiveState();
    }
    if (event is AddNewShopListEvent) {
      await _addNewShopList(event.value);
      yield HomePageActiveState();
    }
    if (event is ChangeCurrencyListIndexEvent) {
      await _changeCurrencyListIndex(event.index);
      yield HomePageActiveState();
    }
    if (event is AddForvardEvent) {
      await _addForvard(event.valueFrom, event.valueTo);
      yield HomePageActiveState();
    }
    if (event is ChangeForvardAccount) {
      await _changeForvardAccount(event.indexAccount, event.index);
      yield HomePageActiveState();
    }
    if (event is DeleteForwardTransaction) {
      await _deleteForwardTransaction(event.index);
      yield HomePageActiveState();
    }
    if (event is DeleteAccountEvent) {
      await _deleteAccount(event.index);
      yield HomePageActiveState();
    }
    if (event is DeleteCloseAccountTransaction) {
      await _deleteCloseAccountTransaction(event.index);
      yield HomePageActiveState();
    }
    if (event is ChangeThemeColorEvent) {
      await _changeThemeColor();
      yield HomePageActiveState();
    }
    if (event is ChangeLangEvent) {
      await _changeLang(event.index);
      yield HomePageActiveState();
    }
    if (event is DeleteShopListEvent) {
      await _deleteShopList(event.value);
      yield HomePageActiveState(); //
    }
    if (event is EditeForwardTransactionEvent) {
      await _editForwardTransaction(event.valueFrom, event.valueTo);
      yield HomePageActiveState(); //
    }
    if (event is EditeTransactionEvent) {
      await _editeTransaction(event.sum, event.currency, event.category,
          event.account, event.currencyListIndex);
      yield HomePageActiveState();
    }
  }

  Future _initial() async {
    var _transactionsBox = await Hive.openBox('transactionsBox');
    // _transactionsBox.clear();
    var _shopListBox = await Hive.openBox('shopListBox');
    var _settingstBox = await Hive.openBox('settingstBox');
    indexLang = await _settingstBox.get('indexLang', defaultValue: indexLang);
    indexTheme =
        await _settingstBox.get('indexTheme', defaultValue: indexTheme);
    // _shopListBox.clear();
    shopList = await _shopListBox.get('shopList', defaultValue: shopList);
    headShopList = await _shopListBox.get('headShopList',
        defaultValue: headShopList = shopList.keys.toList()[0]);
    transactionsList = await _transactionsBox.get('transactionsList',
        defaultValue: transactionsList);
    countsList =
        await _transactionsBox.get('countsList', defaultValue: countsList);
    currencyList =
        await _transactionsBox.get('currencyList', defaultValue: currencyList);
    currencyListIndex = await _transactionsBox.get('currencyListIndex',
        defaultValue: currencyListIndex);
    expensCategorys = await _transactionsBox.get('expensCategorys',
        defaultValue: expensCategorys);
    incomeCategorys = await _transactionsBox.get('incomeCategorys',
        defaultValue: incomeCategorys);

    budgetSum = double.parse(
        currencyList[currencyListIndex]['budget'].toStringAsFixed(2));
    countsSum =
        double.parse(currencyList[currencyListIndex]['sum'].toStringAsFixed(2));
    await _transactionsBox.close();
    await _shopListBox.close();
  }

  _changeCurrencyListIndex(index) async {
    var _transactionsBox = await Hive.openBox('transactionsBox');
    currencyListIndex = index;
    budgetSum = double.parse(
        currencyList[currencyListIndex]['budget'].toStringAsFixed(2));
    countsSum =
        double.parse(currencyList[currencyListIndex]['sum'].toStringAsFixed(2));
    await _transactionsBox.put('currencyListIndex', currencyListIndex);
  }

  _sortTransactions() {
    transactionsList.sort((a, b) => b['id'].compareTo(a['id']));
  }

  Future _addTransaction(eventSum, eventCurrency, eventCategory, eventAccount,
      eventCurrencyListIndex) async {
    indexToSelectAccount = countsList.indexWhere(
        (element) => element['id'] == 'Id$eventAccount$eventCurrency');
    Map _transaction = {
      'sum': eventSum,
      'id': transactionDate.microsecondsSinceEpoch,
      'currency': eventCurrency,
      'category': eventCategory,
      'date': "${transactionDate.day} ",
      'month': "${transactionDate.month}",
      'year': "${transactionDate.year}",
      'account': eventAccount,
      // 'accountId': '$eventAccount$eventCurrency',
    };
    transactionsList.insert(0, _transaction);
    _sortTransactions();
    currencyList[eventCurrencyListIndex]['sum'] += eventSum;
    countsList[indexToSelectAccount]['sum'] += eventSum;
    if (_transaction['sum'] < 0) {
      currencyList[eventCurrencyListIndex]['budget'] += eventSum;
    }
    budgetSum = double.parse(
        currencyList[currencyListIndex]['budget'].toStringAsFixed(2));
    countsSum =
        double.parse(currencyList[currencyListIndex]['sum'].toStringAsFixed(2));
    var _transactionsBox = await Hive.openBox('transactionsBox');
    await _transactionsBox.put('transactionsList', transactionsList);
    await _transactionsBox.put('currencyList', currencyList);
    await _transactionsBox.put('countsList', countsList);
    transactionDate = DateTime.now();
  }

  _editeTransaction(eventSum, eventCurrency, eventCategory, eventAccount,
      eventCurrencyListIndex) async {
    transactionDate = DateTime.fromMicrosecondsSinceEpoch(
        transactionsList[editeTransactionIndex]['id']);
    bool isIncome = transactionsList[editeTransactionIndex]['sum'] > 0;
    indexToSelectAccount = countsList.indexWhere(
        (element) => element['id'] == 'Id$eventAccount$eventCurrency');
    Map _transaction = {
      'sum': isIncome ? eventSum : 0 - eventSum,
      'id': transactionsList[editeTransactionIndex]
          ['id'], // DateTime.now().millisecondsSinceEpoch,
      'currency': eventCurrency,
      'category': eventCategory,
      'date': transactionDate.day.toString() + ' ', //"${DateTime.now().day} ",
      'month': transactionDate.month.toString(), // "${DateTime.now().month}",
      'year': transactionDate.year.toString(), //"${DateTime.now().year}",
      'account': eventAccount,
      // 'accountId': '$eventAccount$eventCurrency',
    };
    _deleteTransaction(editeTransactionIndex);
    transactionsList.insert(editeTransactionIndex, _transaction);
    _sortTransactions();
    currencyList[eventCurrencyListIndex]['sum'] +=
        isIncome ? eventSum : 0 - eventSum;
    countsList[indexToSelectAccount]['sum'] +=
        isIncome ? eventSum : 0 - eventSum;
    if (_transaction['sum'] < 0 &&
        _transaction['month'] == DateTime.now().month.toString()) {
      currencyList[eventCurrencyListIndex]['budget'] +=
          isIncome ? eventSum : 0 - eventSum;
    }
    budgetSum = double.parse(
        currencyList[currencyListIndex]['budget'].toStringAsFixed(2));
    countsSum =
        double.parse(currencyList[currencyListIndex]['sum'].toStringAsFixed(2));
    var _transactionsBox = await Hive.openBox('transactionsBox');
    await _transactionsBox.put('transactionsList', transactionsList);
    await _transactionsBox.put('currencyList', currencyList);
    await _transactionsBox.put('countsList', countsList);
    transactionDate = DateTime.now();
  }

  _addForvard(valueFrom, valueTo) async {
    int currencyIndex1 = currencyList.indexWhere((element) =>
        element['currency'] == countsList[indexForwardAccount1]['currency']);
    int currencyIndex2 = currencyList.indexWhere((element) =>
        element['currency'] == countsList[indexForwardAccount2]['currency']);
    Map _transaction = {
      'sum1': valueFrom,
      'sum2': valueTo,
      'id': transactionDate.microsecondsSinceEpoch,
      'currency1': countsList[indexForwardAccount1]['currency'],
      'currency2': countsList[indexForwardAccount2]['currency'],
      'date': "${transactionDate.day} ",
      'month': "${transactionDate.month}",
      'year': "${transactionDate.year}",
      'account1': countsList[indexForwardAccount1]['name'],
      'account2': countsList[indexForwardAccount2]['name'],
    };
    transactionsList.insert(0, _transaction);
    _sortTransactions();
    currencyList[currencyIndex1]['sum'] += valueFrom;
    currencyList[currencyIndex2]['sum'] += valueTo;
    countsList[indexForwardAccount1]['sum'] += valueFrom;
    countsList[indexForwardAccount2]['sum'] += valueTo;

    countsSum =
        double.parse(currencyList[currencyListIndex]['sum'].toStringAsFixed(2));
    var _transactionsBox = await Hive.openBox('transactionsBox');
    await _transactionsBox.put('transactionsList', transactionsList);
    await _transactionsBox.put('currencyList', currencyList);
    await _transactionsBox.put('countsList', countsList);
    transactionDate = DateTime.now();
  }

  _editForwardTransaction(valueFrom, valueTo) async {
    transactionDate = DateTime.fromMicrosecondsSinceEpoch(
        transactionsList[editeTransactionIndex]['id']);
    int currencyIndex1 = currencyList.indexWhere((element) =>
        element['currency'] == countsList[indexForwardAccount1]['currency']);
    int currencyIndex2 = currencyList.indexWhere((element) =>
        element['currency'] == countsList[indexForwardAccount2]['currency']);
    Map _transaction = {
      'sum1': valueFrom,
      'sum2': valueTo,
      'id': transactionsList[editeTransactionIndex]
          ['id'], // DateTime.now().millisecondsSinceEpoch,
      'currency1': countsList[indexForwardAccount1]['currency'],
      'currency2': countsList[indexForwardAccount2]['currency'],
      'date': transactionDate.day.toString() + ' ', //"${DateTime.now().day} ",
      'month': transactionDate.month.toString(), //"${DateTime.now().month}",
      'year': transactionDate.year.toString(), //"${DateTime.now().year}",
      'account1': countsList[indexForwardAccount1]['name'],
      'account2': countsList[indexForwardAccount2]['name'],
    };
    _deleteForwardTransaction(editeTransactionIndex);
    transactionsList.insert(editeTransactionIndex, _transaction);
    _sortTransactions();
    currencyList[currencyIndex1]['sum'] += valueFrom;
    currencyList[currencyIndex2]['sum'] += valueTo;
    countsList[indexForwardAccount1]['sum'] += valueFrom;
    countsList[indexForwardAccount2]['sum'] += valueTo;

    countsSum =
        double.parse(currencyList[currencyListIndex]['sum'].toStringAsFixed(2));
    var _transactionsBox = await Hive.openBox('transactionsBox');
    await _transactionsBox.put('transactionsList', transactionsList);
    await _transactionsBox.put('currencyList', currencyList);
    await _transactionsBox.put('countsList', countsList);
    transactionDate = DateTime.now();
  }

  Future _deleteTransaction(index) async {
    if (countsList.join().contains(
          'Id${transactionsList[index]['account']}${transactionsList[index]['currency']}',
        )) {
      countsList[countsList.indexWhere((element) =>
              element['name'] == transactionsList[index]['account'])]['sum'] -=
          transactionsList[index]['sum'];
      int eventCurrencyListIndex = currencyList.indexWhere((element) =>
          element['currency'] == transactionsList[index]['currency']);
      currencyList[eventCurrencyListIndex]['sum'] -=
          transactionsList[index]['sum'];

      if (transactionsList[index]['sum'] < 0 &&
          transactionsList[index]['month'] == DateTime.now().month.toString()) {
        currencyList[eventCurrencyListIndex]['budget'] -=
            transactionsList[index]['sum'];
      }
    }
    budgetSum = double.parse(
        currencyList[currencyListIndex]['budget'].toStringAsFixed(2));
    countsSum =
        double.parse(currencyList[currencyListIndex]['sum'].toStringAsFixed(2));
    transactionsList.removeAt(index);
    var _transactionsBox = await Hive.openBox('transactionsBox');
    await _transactionsBox.put('transactionsList', transactionsList);
    await _transactionsBox.put('currencyList', currencyList);
    await _transactionsBox.put('countsList', countsList);
  }

  Future _deleteForwardTransaction(index) async {
    bool transactionAccount1 = countsList.join().contains(
          'Id${transactionsList[index]['account1']}${transactionsList[index]['currency1']}',
        );
    bool transactionAccount2 = countsList.join().contains(
          'Id${transactionsList[index]['account2']}${transactionsList[index]['currency2']}',
        );
    if (transactionAccount1) {
      countsList[countsList.indexWhere((element) =>
              element['name'] == transactionsList[index]['account1'])]['sum'] -=
          transactionsList[index]['sum1'];

      int eventCurrencyListIndex1 = currencyList.indexWhere((element) =>
          element['currency'] == transactionsList[index]['currency1']);
      currencyList[eventCurrencyListIndex1]['sum'] -=
          transactionsList[index]['sum1'];
    }
    if (transactionAccount2) {
      countsList[countsList.indexWhere((element) =>
              element['name'] == transactionsList[index]['account2'])]['sum'] -=
          transactionsList[index]['sum2'];
      int eventCurrencyListIndex2 = currencyList.indexWhere((element) =>
          element['currency'] == transactionsList[index]['currency2']);
      currencyList[eventCurrencyListIndex2]['sum'] -=
          transactionsList[index]['sum2'];
    }
    countsSum =
        double.parse(currencyList[currencyListIndex]['sum'].toStringAsFixed(2));
    transactionsList.removeAt(index);
    var _transactionsBox = await Hive.openBox('transactionsBox');
    await _transactionsBox.put('transactionsList', transactionsList);
    await _transactionsBox.put('currencyList', currencyList);
    await _transactionsBox.put('countsList', countsList);
  }

  _deleteCloseAccountTransaction(index) async {
    countsSum =
        double.parse(currencyList[currencyListIndex]['sum'].toStringAsFixed(2));
    transactionsList.removeAt(index);
    var _transactionsBox = await Hive.openBox('transactionsBox');
    await _transactionsBox.put('transactionsList', transactionsList);
    await _transactionsBox.put('currencyList', currencyList);
    await _transactionsBox.put('countsList', countsList);
  }

  Future _deleteExpenseCategory(index) async {
    if (expensCategorys.length > 1) {
      var _transactionsBox = await Hive.openBox('transactionsBox');
      expensCategorys.removeAt(index);
      await _transactionsBox.put('expensCategorys', expensCategorys);
    }
  } //

  Future _deliteIncomeCategory(index) async {
    if (incomeCategorys.length > 1) {
      var _transactionsBox = await Hive.openBox('transactionsBox');
      incomeCategorys.removeAt(index);
      await _transactionsBox.put('incomeCategorys', incomeCategorys);
    }
  } //

  Future _onsubmitedChangeExpensCategorys(value) async {
    if (value.toString().isNotEmpty) {
      var _transactionsBox = await Hive.openBox('transactionsBox');
      expensCategorys.insert(0, value);
      indexToSelectExpenseCategory = 0;
      await _transactionsBox.put('expensCategorys', expensCategorys);
    }
  }

  Future _onsubmitedChangeIncomeCategorys(value) async {
    if (value.toString().isNotEmpty) {
      var _transactionsBox = await Hive.openBox('transactionsBox');
      incomeCategorys.insert(0, value);
      indexToSelectIncomeCategory = 0;
      await _transactionsBox.put('incomeCategorys', incomeCategorys);
    }
  }

  Future _addAccount(currency, name, sum) async {
    if (currency != '' && name != '') {
      if (countsList.join().contains('Id$name$currency')) {
      } else {
        Map _newcount = {
          'currency': currency,
          'name': name,
          'id': 'Id$name$currency',
          'sum': sum,
        };
        countsList.add(_newcount);
        var _transactionsBox = await Hive.openBox('transactionsBox');

        if (currencyList
            .map((e) => e.values.toString())
            .join()
            .contains('$currency')) {
          currencyList[currencyList.indexWhere(
                  (element) => element.values.toString().contains('$currency'))]
              ['sum'] += sum;
        } else {
          currencyList.add({
            'id': DateTime.now().millisecondsSinceEpoch,
            'currency': currency,
            'sum': sum,
            'budget': 0.0,
          });
        }
        countsSum = double.parse(
            currencyList[currencyListIndex]['sum'].toStringAsFixed(2));
        await _transactionsBox.put('countsList', countsList);
        await _transactionsBox.put('currencyList', currencyList);
      }
    }
  }

  Future _shopListAdd(String value) async {
    Map<String, Object> _newProduct = {
      'product': value,
      'id': DateTime.now().millisecondsSinceEpoch,
      'isBought': true
    };
    if (value.isNotEmpty && value != '') {
      var _shopListBox = await Hive.openBox('shopListBox');
      if (shopList[headShopList]
          .map((e) => e.values.first)
          .map((a) => a)
          .toList()
          .contains(value)) {
        shopList[headShopList][shopList[headShopList].indexWhere(
                (element) => element.values.first.toString().contains(value))]
            ['isBought'] = true;
        _sort(shopList[headShopList]);
        await _shopListBox.put('shopList', shopList);
        await _shopListBox.close();
      } else {
        shopList[headShopList].insert(0, _newProduct);
        _sort(shopList[headShopList]);
        await _shopListBox.put('shopList', shopList);
        await _shopListBox.close();
      }
    }
  }

  void _sort(items) {
    items.sort((a, b) =>
        a['id'].toString().length.compareTo(b['id'].toString().length));
    items.sort((a, b) => a['isBought']
        .toString()
        .length
        .compareTo(b['isBought'].toString().length));
  }

  Future _changeStatusShopListElement(id) async {
    var _shopListBox = await Hive.openBox('shopListBox');
    int index = shopList[headShopList].indexWhere(
        (element) => element.values.toString().contains(id.toString()));
    shopList[headShopList][index]['isBought'] =
        !shopList[headShopList][index]['isBought'];
    _sort(shopList[headShopList]);
    await _shopListBox.put('shopList', shopList);
  }

  Future _deleteShopListElement(index) async {
    var _shopListBox = await Hive.openBox('shopListBox');
    shopList[headShopList].removeAt(index);
    await _shopListBox.put('shopList', shopList);
  }

  _changeHeadShopList(value) async {
    var _shopListBox = await Hive.openBox('shopListBox');
    headShopList = value;
    await _shopListBox.put('headShopList', headShopList);
  }

  _addNewShopList(value) async {
    if (value.isNotEmpty && value != '') {
      var _shopListBox = await Hive.openBox('shopListBox');
      shopList.addEntries([MapEntry(value, [])]);
      await _shopListBox.put('shopList', shopList);
    }
  }

  _deleteShopList(value) async {
    if (shopList.length > 1) {
      shopList.remove(value);
      headShopList = shopList.keys.toList()[0];
      var _shopListBox = await Hive.openBox('shopListBox');
      await _shopListBox.put('shopList', shopList);
      await _shopListBox.put('headShopList', headShopList);
    }
  }

  _changeCurrentPage(index) {
    currentIndex = index;
  }

  _editBudgetSum(value, index) async {
    var _transactionsBox = await Hive.openBox('transactionsBox');
    currencyList[index]['budget'] = value;
    budgetSum = double.parse(
        currencyList[currencyListIndex]['budget'].toStringAsFixed(2));
    _transactionsBox.put('currencyList', currencyList);
  }

  _selectAccount(index) {
    indexToSelectAccount = index;
  }

  _changeForvardAccount(indexAccount, index) {
    if (index == 1) {
      indexForwardAccount1 = indexAccount;
    } else {
      indexForwardAccount2 = indexAccount;
    }
  }

  _deleteAccount(index) async {
    if (countsList.length > 1) {
      String dletedAccountCurenncy = countsList[index]['currency'];
      int deletedCurrencyListIndex = currencyList.indexWhere(
          (element) => element['currency'] == dletedAccountCurenncy);

      Map _transaction = {
        'closeTheAccountSum': countsList[index]['sum'],
        'id': DateTime.now().millisecondsSinceEpoch,
        'currency': countsList[index]['currency'],
        'category': 'close account',
        'date': "${DateTime.now().day} ",
        'month': "${DateTime.now().month}",
        'year': "${DateTime.now().year}",
        'account': countsList[index]['name'],
        // 'accountId': '$eventAccount$eventCurrency',name
      };
      transactionsList.insert(0, _transaction);
      currencyList[deletedCurrencyListIndex]['sum'] -= countsList[index]['sum'];
      countsList.removeAt(index);
      if (!countsList
          .map((e) => e = e['currency'])
          .join()
          .contains(dletedAccountCurenncy)) {
        currencyList.removeAt(deletedCurrencyListIndex);
      }
      if (currencyListIndex > currencyList.length - 1) {
        currencyListIndex = 0;
      }
      countsSum = double.parse(
          currencyList[currencyListIndex]['sum'].toStringAsFixed(2));
      var _transactionsBox = await Hive.openBox('transactionsBox');
      await _transactionsBox.put('currencyListIndex', currencyListIndex);
      await _transactionsBox.put('transactionsList', transactionsList);
      await _transactionsBox.put('currencyList', currencyList);
      await _transactionsBox.put('countsList', countsList);
    }
  }

  _changeLang(index) async {}

  _changeThemeColor() async {
    indexTheme = !indexTheme;
    var _settingstBox = await Hive.openBox('settingstBox');
    await _settingstBox.put('indexTheme', indexTheme);
  }

  blankField(context) {
    return showDialog(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: headcolor2,
            scrollable: true,
            title: const LocaleText("blank field"),
          );
        });
  }
}
