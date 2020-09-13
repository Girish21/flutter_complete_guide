import 'package:flutter/material.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  Widget buildListTile(Icon icon, String title, Function clickHandler) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
      ),
      onTap: clickHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(
              'Hello Friend!',
            ),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          buildListTile(
            Icon(
              Icons.shop,
            ),
            'Shop',
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          buildListTile(
            Icon(
              Icons.payment,
            ),
            'Orders',
            () {
              Navigator.of(context).pushReplacementNamed(
                OrdersScreen.RouteName,
              );
            },
          ),
          Divider(),
          buildListTile(
            Icon(
              Icons.edit,
            ),
            'Manage Products',
            () {
              Navigator.of(context).pushReplacementNamed(
                UserProducts.RouteName,
              );
            },
          ),
        ],
      ),
    );
  }
}
