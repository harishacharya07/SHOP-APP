import 'package:flutter/material.dart';

import '../widget/products_grid.dart';
import '../widget/product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: ProductsGrid(),
    );
  }
}


