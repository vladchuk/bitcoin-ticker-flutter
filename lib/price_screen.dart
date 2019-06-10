import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:javango_lib/dart.dart';
import 'dart:io' show Platform;

import 'coin_card.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Currency currency = Currency.USD;
  Map<Coin, double> prices = {};
  bool isWating = true;

  void initState() {
    super.initState();
    getPrice();
  }

  void getPrice() async {
    isWating = true;
    prices = await CoinData.getPrices(currency);
    isWating = false;
    setState(() {});
  }

  DropdownButton getButton() {
    List<DropdownMenuItem<Currency>> list = [];
    for (Currency c in Currency.values) {
      String name = enumName(c);
      list.add(
        DropdownMenuItem(
          child: Text(name),
          value: c,
        ),
      );
    }

    return DropdownButton<Currency>(
      value: currency,
      items: list,
      onChanged: (Currency c) {
        setState(() {
          currency = c;
        });
        getPrice();
      },
    );
  }

  CupertinoPicker getPicker() {
    List<Text> list = [];
    for (Currency c in Currency.values) {
      list.add(
        Text(c.toString()),
      );
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (index) {
        print(index);
      },
      children: list,
    );
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
              CoinCard(Coin.BTC, currency, prices[Coin.BTC], isWating),
              CoinCard(Coin.ETH, currency, prices[Coin.ETH], isWating),
              CoinCard(Coin.LTC, currency, prices[Coin.LTC], isWating),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getPicker() : getButton(),
          ),
        ],
      ),
    );
  }
}
