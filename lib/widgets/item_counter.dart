import 'package:e_commerce/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/cart_item.dart';
import 'package:e_commerce/providers/cart_provider.dart';

class ItemCounter extends ConsumerWidget {
  const ItemCounter({Key? key, required this.cartItem}) : super(key: key);

  final CartItem cartItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productsProvider.notifier).getProduct(cartItem.id);

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
              onPressed: () {},
              iconSize: 20,
              icon: const Icon(Icons.remove),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              cartItem.quantity.toString(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 30,
            width: 30,
            child: IconButton(
              splashRadius: 0.0001,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 26, maxWidth: 26),
              onPressed: () => ref.read(cartProvider.notifier).addToCart(product),
              iconSize: 20,
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
