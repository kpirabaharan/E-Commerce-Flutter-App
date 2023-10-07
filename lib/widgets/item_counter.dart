import 'package:e_commerce/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/providers/cart_provider.dart';

class ItemCounter extends ConsumerStatefulWidget {
  const ItemCounter({Key? key, required this.cartItemId}) : super(key: key);

  final String cartItemId;

  @override
  ConsumerState<ItemCounter> createState() => _ItemCounterState();
}

class _ItemCounterState extends ConsumerState<ItemCounter> {
  @override
  Widget build(BuildContext context) {
    final product = ref.watch(productsProvider.notifier).getProduct(widget.cartItemId);
    final cartItem =
        ref.watch(cartProvider).firstWhere((element) => element.id == widget.cartItemId);

    print(cartItem.quantity);

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
              cartItem.quantity.toString(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
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
