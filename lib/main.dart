import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/providers/order_list.dart';
import 'package:shop/providers/product_list.dart';
import 'package:shop/utils/routes.dart';
import 'package:shop/views/auth_page.dart';
import 'package:shop/views/cart_page.dart';
import 'package:shop/views/orders_page.dart';
import 'package:shop/views/product_detail_page.dart';
import 'package:shop/views/product_form_page.dart';
import 'package:shop/views/product_manage.dart';
import 'package:shop/views/products_page.dart';
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
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => new OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: const ColorScheme.light(),
          //.copyWith(primary: const Color.fromARGB(255, 159, 125, 219)),
          primaryColor: const Color.fromARGB(255, 151, 90, 255),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: const ColorScheme.dark(),
          primaryColor: const Color.fromARGB(255, 159, 125, 219),
          useMaterial3: true,
        ),
        // home: const ProductsPage(),
        routes: {
          Routes.AUTH: (context) => const AuthPage(),
          Routes.HOME: (context) => const ProductsPage(),
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
