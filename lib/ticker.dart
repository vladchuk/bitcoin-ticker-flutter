import 'package:flutter/foundation.dart';
import 'dart:io';
import 'coin_data.dart';

class Ticker with ChangeNotifier {
  Currency _currency = Currency.UAH;
  Map<Coin, double> _prices = {};
  bool _waiting;

  bool get initialized => _prices.isNotEmpty;

  Currency get currency => _currency;

  set currency(Currency value) {
    _currency = value;
    notifyListeners();
  }

  bool get waiting => _waiting;

  Map<Coin, double> get prices => _prices;

  void updatePrices() async {
    update();
//    while (true) {
//      Future.delayed(Duration(seconds: 10), update);
//    }
  }

  void update() async {
    _waiting = true;
    print('Getting prices.............');
    _prices = await CoinData.getPrices(_currency);
    print('Got prices!!!!!!!!!!!!!!!');
    notifyListeners();
    _waiting = false;
  }
}
