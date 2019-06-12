import 'package:flutter/material.dart';
import 'package:javango_lib/dart.dart';
import 'package:provider/provider.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/ticker.dart';

class CoinCard extends StatelessWidget {
  final Coin coin;

  CoinCard(this.coin);

  @override
  Widget build(BuildContext context) {
    final ticker = Provider.of<Ticker>(context);
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
            format(ticker),
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

  String format(Ticker ticker) {
    String c = enumName(coin);
    String cr = ticker.waiting ? '' : enumName(ticker.currency);
    String pr = ticker.waiting ? '...' : ticker.prices[coin].toStringAsFixed(2);
    return '1 $c = $pr $cr';
  }
}
