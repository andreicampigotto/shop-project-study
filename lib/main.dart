import 'package:flutter/material.dart';
import 'package:shop/providers/product_list.dart';
import 'package:shop/utils/routes.dart';
import 'package:shop/views/items/product_detail.dart';
import 'package:shop/views/products_overview_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, secondary: Colors.amber),
          fontFamily: 'Lato',
          useMaterial3: true,
        ),
        home: ProductsOverviewPage(),
        routes: {Routes.PRODUCT_DETAIL: (ctx) => ProductDetail()},
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
