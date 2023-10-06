import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/utils/currency_formatter.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce/models/cart_item.dart';
import 'package:e_commerce/widgets/item_counter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartTile extends ConsumerWidget {
  const CartTile(this.cartItem, {super.key});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(cartItem.id),
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.name,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                  ),
                  Text(
                    currencyFormatter(cartItem.price, quantity: cartItem.quantity),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              height: 120,
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Spacer(),
                  ItemCounter(cartItem: cartItem),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
