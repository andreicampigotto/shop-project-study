import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(141, 142, 89, 234),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            Card(
              borderOnForeground: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              elevation: 0,
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
              color: const Color.fromARGB(255, 255, 255, 82),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(17, 10, 0, 10),
                child: Row(
                  children: [
                    Text(
                      '\$ ${product.price}',
                      style: const TextStyle(
                        color: Color.fromARGB(211, 61, 28, 28),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              width: double.infinity,
              child: Text(
                product.description!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
