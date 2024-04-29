import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/utils/routes.dart';
import 'package:shop/views/cart/cart_page.dart';
import 'package:shop/views/orders/orders_page.dart';
import 'package:shop/views/manage/product_manage.dart';
import 'package:shop/views/products/product_grid.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreen();
}

class _TabsScreen extends State<TabsScreen> {
  int _currentPageIndex = 0;
  List<Map<String, Object>>? _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      {
        'title': 'Shop',
        'screen': const ProductGrid(),
      },
      {
        'title': 'Cart',
        'screen': const CartPage(),
      },
      {
        'title': 'Orders',
        'screen': const OrdersPage(),
      },
      {
        'title': 'Settings',
        'screen': const ProductManage(),
      },
    ];
  }

  _selectedScreen(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentPageIndex == 3
          ? AppBar(
              title: Text(
                _screens![_currentPageIndex]['title'] as String,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.PRODUCT_FORM);
                  },
                ),
              ],
            )
          : AppBar(
              title: Text(
                _screens![_currentPageIndex]['title'] as String,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.exit_to_app_outlined),
                  onPressed: () {
                    Provider.of<Auth>(context, listen: false).logout();
                    Navigator.of(context)
                        .pushReplacementNamed(Routes.AUTH_OR_HOME);
                  },
                ),
              ],
            ),
      body: _screens![_currentPageIndex]['screen'] as Widget,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _selectedScreen,
        indicatorColor: Colors.amber,
        selectedIndex: _currentPageIndex,
        destinations: <Widget>[
          const NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Shop',
          ),
          Consumer<Cart>(
            builder: (_, cart, child) => NavigationDestination(
              selectedIcon: const Icon(Icons.shopping_cart),
              icon: Badge(
                label: Text(cart.itemsCount.toString()),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
              label: 'Cart',
            ),
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.payment),
            icon: Icon(Icons.payment_outlined),
            label: 'Orders',
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
