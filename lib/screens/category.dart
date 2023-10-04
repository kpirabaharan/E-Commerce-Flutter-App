import 'dart:io' show Platform;

import 'package:e_commerce/actions/get_products.dart';
import 'package:e_commerce/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/actions/get_billboard.dart';

import 'package:e_commerce/widgets/billboard_poster.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billboard = ref.watch(getBillboard);
    final products = ref.watch(getProducts);

    return billboard.when(
      skipLoadingOnReload: true,
      data: (billboard) => Column(
        children: [
          Flexible(flex: 1, child: BillboardPoster(billboard: billboard)),
          products.when(
            data: (products) => Flexible(
              flex: 2,
              child: GridView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                children: products.map((product) => ProductItem(product: product)).toList(),
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Text('Error: $error'),
          ),
        ],
      ),
      error: (error, stackTrace) => Text('Error: $error'),
      loading: () => Platform.isIOS
          ? const Center(child: CupertinoActivityIndicator())
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
