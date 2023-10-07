import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:e_commerce/providers/active_store_provider.dart';
import 'package:e_commerce/providers/cart_provider.dart';

import 'package:e_commerce/widgets/cart_total.dart';
import 'package:e_commerce/widgets/cart_tile.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider.notifier).getItems(ref.read(activeStoreProvider)!.id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Cart'),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text(
                'Your Cart is Empty',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: cartItems.map((cartItem) => CartTile(cartItem)).toList(),
                  ),
                ),
                const CartTotal(),
              ],
            ),
    );
  }
}
