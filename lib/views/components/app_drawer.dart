import 'package:flutter/material.dart';

import '../../utils/routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Welcome'),
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Store'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                Routes.HOME,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                Routes.ORDERS,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Product manager'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                Routes.PRODUCT_MANAGE,
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
