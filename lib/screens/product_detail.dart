import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:e_commerce/models/product.dart';

import 'package:e_commerce/widgets/product_gallery.dart';
import 'package:e_commerce/widgets/product_info.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
          ),
        ],
      ),
      body: Column(children: [
        ProductGallery(product.id, product.images),
        Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          width: double.infinity,
          child: ProductInfo(product),
        )
      ]),
    );
  }
}
