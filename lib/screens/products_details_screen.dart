import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  //final String title;

  //ProductDetailsScreen();

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
    );
  }
}
