import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.name),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: product.id,
                    child: Image.network(
                      product.imageUrl!,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                    begin: Alignment(0, 0.8),
                    end: Alignment(0, 0.0),
                    colors: [
                      Color.fromRGBO(0, 0, 0, 0.6),
                      Color.fromRGBO(0, 0, 0, 0),
                    ],
                  )))
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: const EdgeInsets.only(top: 16, bottom: 16, right: 8),
                color: const Color.fromRGBO(255, 95, 31, 1),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      textAlign: TextAlign.end,
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
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: Text(
                  product.description!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
