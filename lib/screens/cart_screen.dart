import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../provider/orders.dart';

import '../provider/cart.dart';
import '../widget/cart_item.dart' as ci;

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

var _isLoaded = false;

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: (cart.totalAmount <= 0 || _isLoaded)
                        ? null
                        : () async {
                            setState(() {
                              _isLoaded = true;
                            });
                            await Provider.of<Orders>(context, listen: false)
                                .addOrder(
                              cart.items.values.toList(),
                              cart.totalAmount,
                            );
                            setState(() {
                              _isLoaded = false;
                            });
                            cart.clearCart();
                          },
                    child: _isLoaded
                        ? CircularProgressIndicator()
                        : Text('Order Now'),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => ci.CartItem(
                id: cart.items.values.toList()[i].id,
                title: cart.items.values.toList()[i].title,
                quantity: cart.items.values.toList()[i].quantity,
                price: cart.items.values.toList()[i].price,
                productId: cart.items.keys.toList()[i],
              ),
              itemCount: cart.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
