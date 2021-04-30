import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widget/product_item.dart';
import '../provider/products.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;

  ProductsGrid(this.showFav);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFav ? productsData.favoritesOnly: productsData.item;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(
          //products[i].id,
          //products[i].title,
          //products[i].imageUrl,
        ),
      ),
      itemCount: products.length,
    );
  }
}
