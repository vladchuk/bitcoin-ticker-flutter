import 'dart:async';

import 'package:flutter/foundation.dart';
import 'dart:io';
import 'coin_data.dart';

class Ticker with ChangeNotifier {
  Currency _currency = Currency.UAH;
  Map<Coin, double> _prices = {};
  bool _waiting;
  Timer _timer;

  bool get initialized => _prices.isNotEmpty;

  Currency get currency => _currency;

  set currency(Currency value) {
    _currency = value;
    if (_timer != null) _timer.cancel();
    _prices.clear();
    notifyListeners();
  }

  bool get waiting => _waiting;

  Map<Coin, double> get prices => _prices;

  void updatePrices() async {
    update();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      update();
    });
  }

  void update() async {
    _waiting = true;
    print('Getting prices.............');
    _prices = await CoinData.getPrices(_currency);
    print('Got prices!!!!!!!!!!!!!!!');
    _waiting = false;
    notifyListeners();
  }
}
