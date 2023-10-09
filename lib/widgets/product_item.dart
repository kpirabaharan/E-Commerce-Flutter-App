import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/utils/currency_formatter.dart';

import 'package:e_commerce/screens/product_detail.dart';

class ProductItem extends ConsumerWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => ProductDetailScreen(
              product: product,
            ),
          ),
        );
      },
      child: SizedBox(
        height: (width - 20) * 0.5,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: (width - 20) * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surfaceVariant,
              ),
              child: Stack(alignment: Alignment.center, children: [
                Hero(
                  tag: product.id,
                  child: Image.network(
                    product.images[0].url,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    focusColor: Colors.transparent,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    icon: Icon(
                      Platform.isIOS ? CupertinoIcons.cart_badge_plus : Icons.add_shopping_cart,
                    ),
                    onPressed: () => ref.read(cartProvider.notifier).addItem(product),
                  ),
                ),
              ]),
            ),
            Text(
              product.name,
              style: Theme.of(context).textTheme.titleMedium!,
            ),
            Text(
              currencyFormatter(product.price),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: product.color.value,
                  border: Border.all(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
