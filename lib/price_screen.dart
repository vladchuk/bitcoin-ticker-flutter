import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:javango_lib/dart.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currency = 'USD';
  double price;

  void initState() {
    super.initState();
    getPrice(currency, 'BTC');
  }

  void getPrice(String currency, String coin) async {
    double p = await CoinData.getPrice(currency, coin);
    setState(() {
      this.currency = currency;
      price = p;
    });
  }

  DropdownButton getButton() {
    List<DropdownMenuItem<String>> list = [];
    for (Currency c in Currency.values) {
      String name = enumName(c);
      list.add(
        DropdownMenuItem(
          child: Text(name),
          value: name,
        ),
      );
    }

    return DropdownButton<String>(
      value: currency,
      items: list,
      onChanged: (value) async {
        getPrice(value, 'BTC');
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

  String format(String coin, String currency, double price) {
    return '1 $coin = ${price == null ? '...' : '$price'} $currency';
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
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  format('BTC', currency, price),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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
