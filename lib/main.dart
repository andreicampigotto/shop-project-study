// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/providers/order_list.dart';
import 'package:shop/providers/product_list.dart';
import 'package:shop/utils/routes.dart';
import 'package:shop/views/auth_or_home.dart';
import 'package:shop/views/cart/cart_page.dart';
import 'package:shop/views/orders/orders_page.dart';
import 'package:shop/views/products/product_detail_page.dart';
import 'package:shop/views/manage/product_form_page.dart';
import 'package:shop/views/manage/product_manage.dart';
import 'package:provider/provider.dart';
// import 'package:system_theme/system_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
            create: (_) => ProductList(),
            update: (_, auth, product) {
              return ProductList(auth.idToken ?? '', auth.userId ?? '',
                  product?.products ?? []);
            }),
        ChangeNotifierProxyProvider<Auth, OrderList>(
            create: (_) => new OrderList(),
            update: (_, auth, order) => OrderList(
                auth.idToken ?? '', order?.orderList ?? [], auth.userId ?? '')),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: const ColorScheme.light(),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: const ColorScheme.dark(),
          useMaterial3: true,
        ),
        // home: const ProductsPage(),
        routes: {
          Routes.AUTH_OR_HOME: (context) => const AuthOrHomePage(),
          Routes.PRODUCT_DETAIL: (context) => const ProductDetailPage(),
          Routes.CART: (context) => const CartPage(),
          Routes.ORDERS: (context) => const OrdersPage(),
          Routes.PRODUCT_MANAGE: (context) => const ProductManage(),
          Routes.PRODUCT_FORM: (context) => const ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
