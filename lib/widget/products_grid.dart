import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widget/product_item.dart';
import '../models/product.dart';
import '../provider/products.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    Key key,
    @required this.loadedProducts,
  }) : super(key: key);

  final List<Product> loadedProducts;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.item;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ProductItem(
        products[i].id,
        products[i].title,
        products[i].imageUrl,
      ),
      itemCount: products.length,
    );
  }
}
