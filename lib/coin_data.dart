import 'dart:io';

import 'package:javango_lib/dart.dart' as javango;

enum Currency {
  AUD,
  CAD,
  EUR,
  GBP,
  HKD,
  RUB,
  UAH,
  USD,
}

enum Coin {
  BTC,
  ETH,
  LTC,
}

const String baseUrl = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

class CoinData {
  static Future<double> getPrice(Currency currency, Coin coin) async {
    String url = baseUrl + javango.enumName(coin) + javango.enumName(currency);
    javango.HttpResponse res = await javango.getHttpData(url);
    if (!res.success) print('url=$url, error=${res.error}');
    javango.JsonResponse jsonRes = javango.parseJson(res.data);
    double price = jsonRes.data['last'];
    return price;
  }

  static Future<Map<Coin, double>> getPrices(Currency currency) async {
    Map<Coin, double> map = {};
    for (Coin coin in Coin.values) {
      map[coin] = await CoinData.getPrice(currency, coin);
    }
    return map;
  }
}
