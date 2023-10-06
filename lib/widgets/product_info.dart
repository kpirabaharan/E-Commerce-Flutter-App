import 'package:e_commerce/utils/currency_formatter.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce/models/product.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white),
        ),
        Text(
          currencyFormatter(product.price),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
        ),
        Row(
          children: [
            Text('Size: ${product.size.name}',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
            const Padding(padding: EdgeInsets.only(left: 20)),
            Row(
              children: [
                Text('Color: ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: product.color.value,
                    border: Border.all(color: Colors.grey[400]!),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
