import 'dart:io' show Platform;

import 'package:e_commerce/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:e_commerce/models/product.dart';

import 'package:e_commerce/widgets/product_gallery.dart';
import 'package:e_commerce/widgets/product_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(product.name),
        actions: [
          IconButton(
            icon: Icon(
              Platform.isIOS ? CupertinoIcons.cart : Icons.shopping_cart_outlined,
            ),
            onPressed: () => Navigator.of(context).pushReplacementNamed('/cart'),
          ),
        ],
      ),
      body: Column(children: [
        ProductGallery(product.id, product.images),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          width: double.infinity,
          child: ProductInfo(product),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: FilledButton(
            onPressed: () => ref.read(cartProvider.notifier).addItem(product),
            child: const Text('Add to Cart'),
          ),
        ),
      ]),
    );
  }
}
