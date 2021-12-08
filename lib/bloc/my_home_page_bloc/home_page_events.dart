part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class HomePageInitialstate extends HomePageEvent {}

class HomePageEditeCurrentPage extends HomePageEvent {
  final int index;

  HomePageEditeCurrentPage(this.index);
}

class AddTransactionEvent extends HomePageEvent {
  final int currencyListIndex;
  final double sum;
  final String currency;
  final String category;
  final String account;

  AddTransactionEvent(this.currencyListIndex, this.sum, this.currency,
      this.category, this.account);
}

class DeleteTransactionEvent extends HomePageEvent {
  final int index;

  DeleteTransactionEvent(this.index); //
}

class DeliteExpenseCategory extends HomePageEvent {
  final int index;

  DeliteExpenseCategory(this.index);
}

class DeliteIncomeCategory extends HomePageEvent {
  final int index;

  DeliteIncomeCategory(this.index);
}

class OnsubmitedChangeExpensCategorys extends HomePageEvent {
  final String value;

  OnsubmitedChangeExpensCategorys(this.value); //
}

class OnsubmitedChangeIncomeCategorys extends HomePageEvent {
  final String value;

  OnsubmitedChangeIncomeCategorys(this.value); //
}

class AddAccountEvent extends HomePageEvent {
  final String currency;
  final String name;
  final double sum;

  AddAccountEvent(this.currency, this.name, this.sum);
}

class FullListChangeStatus extends HomePageEvent {
  final int value;

  FullListChangeStatus(this.value); //
}

class ShopListAddElementEvent extends HomePageEvent {
  final String value;

  ShopListAddElementEvent(this.value); //
}

class ShopListDeleteElementEvent extends HomePageEvent {
  final int value;

  ShopListDeleteElementEvent(this.value); //EditBudgetSumEvent
}

class EditBudgetSumEvent extends HomePageEvent {
  final double value;
  final int index;

  EditBudgetSumEvent(this.value, this.index); //SelectAccountEvent
}

class SelectAccountEvent extends HomePageEvent {
  final int index;

  SelectAccountEvent(this.index); //
}

class ChangeHeadShopListEvent extends HomePageEvent {
  final String value;

  ChangeHeadShopListEvent(this.value); //
}

class AddNewShopListEvent extends HomePageEvent {
  final String value;

  AddNewShopListEvent(this.value); //
}

class ChangeCurrencyListIndexEvent extends HomePageEvent {
  final int index;

  ChangeCurrencyListIndexEvent(this.index); //
}

class AddForvardEvent extends HomePageEvent {
  final double valueFrom;
  final double valueTo;

  AddForvardEvent(this.valueFrom, this.valueTo); //
}

class ChangeForvardAccount extends HomePageEvent {
  final int index;
  final int indexAccount;

  ChangeForvardAccount(this.index, this.indexAccount); //
}

class DeleteForwardTransaction extends HomePageEvent {
  final int index;

  DeleteForwardTransaction(this.index); //
}

class DeleteAccountEvent extends HomePageEvent {
  final int index;

  DeleteAccountEvent(this.index); //
}

class DeleteCloseAccountTransaction extends HomePageEvent {
  final int index;

  DeleteCloseAccountTransaction(this.index);
}

class ChangeLangEvent extends HomePageEvent {
  final int index;

  ChangeLangEvent(this.index);
}

class ChangeThemeColorEvent extends HomePageEvent {
  // final int index;

  // ChangeThemeColorEvent(this.index); //
}

class DeleteShopListEvent extends HomePageEvent {
  final String value;

  DeleteShopListEvent(this.value); //
}

class EditeForwardTransactionEvent extends HomePageEvent {
  final double valueFrom;
  final double valueTo;

  EditeForwardTransactionEvent(this.valueFrom, this.valueTo);
}

class EditeTransactionEvent extends HomePageEvent {
  final int currencyListIndex;
  final double sum;
  final String currency;
  final String category;
  final String account;

  EditeTransactionEvent(this.currencyListIndex, this.sum, this.currency,
      this.category, this.account);
}
