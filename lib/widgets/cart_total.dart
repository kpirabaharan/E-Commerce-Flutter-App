import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/store.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/active_store_provider.dart';

import 'package:e_commerce/screens/checkout.dart';

class CartTotal extends ConsumerWidget {
  const CartTotal({Key? key}) : super(key: key);

  void showCheckoutModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const Checkout(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeStore = ref.watch(activeStoreProvider) as Store;
    final cartTotalCost = ref
        .watch(cartProvider)
        .where((item) => item.storeId == activeStore.id)
        .fold<double>(
            0,
            (previousValue, element) =>
                previousValue + (double.parse(element.price) * element.quantity));
    final cartTotalItems = ref
        .watch(cartProvider)
        .where((item) => item.storeId == activeStore.id)
        .fold<int>(0, (previousValue, element) => previousValue + element.quantity);

    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Card(
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '$cartTotalItems items',
                        style: Theme.of(context).textTheme.titleMedium,
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
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Free Shipping',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ]),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: FilledButton(
                onPressed: () => showCheckoutModal(context),
                child: const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
