import 'package:flutter/material.dart';

import 'package:e_commerce/models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    print(product.color.value);
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: (width - 20) * 0.5,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey[300],
            height: (width - 20) * 0.3,
            width: double.infinity,
            child: Image.network(
              product.images[0].url,
              fit: BoxFit.contain,
            ),
          ),
          Text(
            product.name,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
          ),
          Text(
            '\$${product.price}',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white70),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(shape: BoxShape.circle, color: product.color.value),
            ),
          )
        ],
      ),
    );
  }
}
