import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop/provider/orders.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/orders_screen.dart';

import './screens/products_details_screen.dart';
import './screens/products_overview_screen.dart';
import './provider/products.dart';
import './provider/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        routes: {
          '/': (ctx) => ProductsOverviewScreen(),
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
