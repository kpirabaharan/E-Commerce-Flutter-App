import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/providers/products_provider.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/utils/currency_formatter.dart';

import 'package:e_commerce/widgets/item_counter.dart';

class CartTile extends ConsumerWidget {
  const CartTile({super.key, required this.cartItemId});

  final String cartItemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItem =
        ref.watch(cartProvider).firstWhereOrNull((element) => element.id == cartItemId);
    final product = ref.watch(productsProvider).firstWhere((element) => element.id == cartItemId);

    return Dismissible(
      key: Key(cartItem!.id),
      onDismissed: (direction) => ref.read(cartProvider.notifier).removeBatch(cartItem.id),
      background: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red,
          ),
          child: const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          )),
      direction: DismissDirection.endToStart,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              color: Colors.grey[400],
              margin: const EdgeInsets.all(10),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(cartItem.image.url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 120,
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartItem.name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          currencyFormatter(cartItem.price, quantity: cartItem.quantity),
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.white70,
                              ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Spacer(),
                        ItemCounter(product: product, quantity: cartItem.quantity),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
