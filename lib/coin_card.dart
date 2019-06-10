import 'package:flutter/material.dart';
import 'package:javango_lib/dart.dart';

import 'coin_data.dart';

class CoinCard extends StatelessWidget {
  final Coin coin;
  final Currency currency;
  final double price;
  final bool isWaiting;

  CoinCard(this.coin, this.currency, this.price, this.isWaiting);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            format(coin, currency, price),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  String format(Coin coin, Currency currency, double price) {
    String c = enumName(coin);
    String cr = enumName(currency);
    String pr = isWaiting ? '...' : price.toStringAsFixed(2);
    return '1 $c = $pr $cr';
  }
}
