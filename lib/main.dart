import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/product.dart';
import './providers/products.dart';
import './screens/auth_screen.dart';
import './screens/cart_screen.dart';
import './screens/edit_product.dart';
import './screens/orders_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: null,
          update: (ctx, auth, previous) => Products(
            token: auth.token,
            userId: auth.userId,
            products: previous == null ? List<Product>() : previous.products,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: null,
          update: (ctx, auth, orders) => Orders(
            token: auth.token,
            orders: orders == null ? List<OrderItem>() : orders.orders,
            userId: auth.userId,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, value, _) => MaterialApp(
          title: 'My Shop',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: value.isAuthenticated ? ProductsOverview() : AuthScreen(),
          routes: {
            ProductDetail.RouteName: (ctx) => ProductDetail(),
            ShoppingCart.RouteName: (ctx) => ShoppingCart(),
            OrdersScreen.RouteName: (ctx) => OrdersScreen(),
            UserProducts.RouteName: (ctx) => UserProducts(),
            EditProduct.RouteName: (ctx) => EditProduct(),
          },
        ),
      ),
    );
  }
}
