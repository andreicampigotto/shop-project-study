import 'package:flutter/material.dart';
import 'package:shop/views/auth/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.055,
                  ),
                  const Text(
                    'My Shop',
                    style: TextStyle(fontSize: 40, fontFamily: 'Anton'),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.088,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    child: const AuthForm(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
