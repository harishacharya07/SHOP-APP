import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './screens/products_details_screen.dart';
import './screens/products_overview_screen.dart';
import './provider/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (ctx) => Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
        },
      ),
    );
  }
}


