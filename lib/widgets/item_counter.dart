import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/cart_provider.dart';

class ItemCounter extends ConsumerWidget {
  const ItemCounter({Key? key, required this.product, required this.quantity}) : super(key: key);

  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Colors.purple[900],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: IconButton(
              splashRadius: 0.0001,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 26, maxWidth: 26),
              onPressed: () => ref.read(cartProvider.notifier).removeItem(product.id),
              iconSize: 20,
              icon: const Icon(Icons.remove),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                quantity.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              )),
          SizedBox(
            height: 30,
            width: 30,
            child: IconButton(
              splashRadius: 0.0001,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 26, maxWidth: 26),
              onPressed: () => ref.read(cartProvider.notifier).addItem(product),
              iconSize: 20,
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
