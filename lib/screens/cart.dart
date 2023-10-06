import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/providers/active_store_provider.dart';
import 'package:e_commerce/providers/cart_provider.dart';

import 'package:e_commerce/widgets/cart_tile.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref
        .watch(cartProvider)
        .where((cartItem) => cartItem.storeId == ref.read(activeStoreProvider)!.id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: cartItems.map((cartItem) => CartTile(cartItem)).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '\$${ref.watch(cartProvider.notifier).getTotal(ref.read(activeStoreProvider)!.id).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
