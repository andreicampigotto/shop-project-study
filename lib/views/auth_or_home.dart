import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/views/auth_page.dart';
import 'package:shop/views/components/tab_screen.dart';
// import 'package:shop/views/products_page.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return auth.isAuth ? const TabsScreen() : const AuthPage();
  }
}
