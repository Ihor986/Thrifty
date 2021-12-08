import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:thrifty/vars/text.dart';
import 'bloc/my_home_page_bloc/home_page_bloc.dart';
import 'pages/home_page/home_page.dart';
import 'pages/settings_drower/settings_drower_budget.dart';
import 'pages/settings_drower/settings_drower_counts.dart';
import 'pages/settings_drower/settings_drower_counts_head.dart';
import 'pages/settings_drower/settings_drower_settings.dart';
import 'pages/settings_drower/settings_drower_shop_list.dart';
import 'pages/transactions_page/add_expense_page.dart';
import 'pages/transactions_page/add_forward_page.dart';
import 'pages/transactions_page/add_income_page.dart';
import 'pages/transactions_page/edite_forward_page.dart';
import 'pages/transactions_page/edite_transaction_page.dart';
import 'package:flutter_locales/flutter_locales.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'ru']);
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
        builder: (locale) => MultiBlocProvider(
              providers: [
                BlocProvider<HomePageBloc>(
                  create: (context) => HomePageBloc(HomePageInitActiveState())
                    ..add(HomePageInitialstate()),
                ),
              ],
              child: MaterialApp(
                  localizationsDelegates: Locales.delegates,
                  supportedLocales: Locales.supportedLocales,
                  locale: locale,
                  debugShowCheckedModeBanner: false,
                  title: myMoneyText,
                  theme: ThemeData(
                    primarySwatch: Colors.teal,
                  ),
                  initialRoute: '/',
                  routes: <String, WidgetBuilder>{
                    '/': (BuildContext context) => const MyHomePage(),
                    '/EnterIncomesPage': (BuildContext context) =>
                        const EnterIncomesPage(),
                    '/EnterTheExpensePage': (BuildContext context) =>
                        const EnterTheExpensePage(),
                    '/EnterForwardPage': (BuildContext context) =>
                        const EnterForwardPage(),
                    '/EditeForwardTransactionPage': (BuildContext context) =>
                        const EditeForwardPage(),
                    '/EditeTransactionPage': (BuildContext context) =>
                        const EditeTransactionPage(),
                    '/SettingsBudget': (BuildContext context) =>
                        const SettingsBudget(),
                    '/SettingsCounts': (BuildContext context) =>
                        const SettingsCounts(),
                    '/SettingsCountsHead': (BuildContext context) =>
                        const SettingsCountsHead(),
                    '/SettingsShopList': (BuildContext context) =>
                        const SettingsShopList(),
                    '/SettingsSettings': (BuildContext context) =>
                        const SettingsSettings(),
                  }),
            ));

    // });
  }
}
