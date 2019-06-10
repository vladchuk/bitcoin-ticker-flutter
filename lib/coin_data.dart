import 'package:javango_lib/dart.dart' as javango;

enum Currency {
  AUD,
  BRL,
  CAD,
  CNY,
  EUR,
  GBP,
  HKD,
  IDR,
  ILS,
  INR,
  JPY,
  MXN,
  NOK,
  NZD,
  PLN,
  RON,
  RUB,
  SEK,
  SGD,
  UAH,
  USD,
  ZAR
}

enum Coin {
  BTC,
  ETH,
  LTC,
}

const String baseUrl = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

class CoinData {
  static Future<double> getPrice(String currency, String coin) async {
    String url = baseUrl + coin + currency;
    javango.HttpResponse res = await javango.getHttpData(url);
    if (!res.success) print('url=$url, error=${res.error}');
    javango.JsonResponse jsonRes = javango.parseJson(res.data);
    double price = jsonRes.data['last'];
    return price;
  }
}
