import 'package:bitcoin_ticker/ticker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'price_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(primaryColor: Colors.lightBlue, scaffoldBackgroundColor: Colors.white),
      home: ChangeNotifierProvider(
        builder: (context) => Ticker(),
        child: PriceScreen(),
      ),
    );
  }
}
