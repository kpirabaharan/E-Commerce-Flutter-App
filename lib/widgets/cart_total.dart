import 'package:e_commerce/providers/active_store_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/providers/cart_provider.dart';

class CartTotal extends ConsumerWidget {
  const CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeStore = ref.watch(activeStoreProvider);
    final cartTotalCost = ref.watch(cartProvider.notifier).getTotal(activeStore!.id);
    final cartTotalItems = ref.watch(cartProvider.notifier).getItemCount(activeStore!.id);
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Card(
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                      ),
                      Text(
                        '$cartTotalItems items',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${cartTotalCost.toStringAsFixed(2)}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Free Shipping',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ]),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: FilledButton(
                onPressed: () {},
                child: const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
