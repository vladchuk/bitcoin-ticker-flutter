import 'package:bitcoin_ticker/ticker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:javango_lib/dart.dart';
import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_card.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:provider/provider.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Ticker ticker = Provider.of<Ticker>(context);
    if (!ticker.initialized) {
      ticker.updatePrices();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CoinCard(Coin.BTC),
              CoinCard(Coin.ETH),
              CoinCard(Coin.LTC),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CurrencyButton(), //Platform.isIOS ? getPicker() : getButton(price),
          ),
        ],
      ),
    );
  }
}

class CurrencyButton extends StatelessWidget {
  final List<DropdownMenuItem<Currency>> list = [];

  CurrencyButton() {
    for (Currency c in Currency.values) {
      String name = enumName(c);
      list.add(
        DropdownMenuItem(
          child: Text(name),
          value: c,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ticker = Provider.of<Ticker>(context);
    return DropdownButton<Currency>(
      value: ticker.currency,
      items: list,
      onChanged: (Currency c) {
        ticker.currency = c;
        ticker.updatePrices();
      },
    );
  }
}
