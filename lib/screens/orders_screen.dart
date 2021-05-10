import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/app_drawer.dart';

import '../provider/orders.dart' show Orders;
import '../widget/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) => {
      Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItem(
          orderData.orders[i],
        ),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
