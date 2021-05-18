import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/user_product_screen.dart';
import '../screens/orders_screen.dart';
import '../provider/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          Divider(
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Mange Products'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
            },
          ),
          Divider(
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context).logout();
            },
          ),
        ],
      ),
    );
  }
}
