import 'package:flutter/material.dart';
import 'package:shop/views/components/auth_form.dart';

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
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 80,
                  ),
                  //transform: Matrix4.rotationZ(-8 * pi / 180),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.amber,
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 8,
                            color: Colors.black,
                            offset: Offset(0, 2))
                      ]),
                  child: const Text(
                    'Shop',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Anton',
                    ),
                  ),
                ),
                AuthForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
