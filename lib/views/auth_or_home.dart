import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/views/auth/auth_page.dart';
import 'package:shop/views/tab_screen.dart';
// import 'package:shop/views/products_page.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    //return auth.isAuth ? const TabsScreen() : const AuthPage();

    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return const Center(child: Text('Something is wrong'));
        } else {
          return auth.isAuth ? const TabsScreen() : const AuthPage();
        }
      },
    );
  }
}
