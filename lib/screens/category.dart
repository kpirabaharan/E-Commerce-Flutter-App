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
      data: (billboard) => CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(billboard.label),
            background: Image.network(billboard.imageUrl, fit: BoxFit.cover),
          ),
        ),
        products.when(
          data: (products) => SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (ctx, index) => ProductItem(product: products[index]),
                childCount: products.length,
              ),
            ),
          ),
          error: (error, stackTrace) => SliverToBoxAdapter(
            child: Center(child: Text('Error: $error')),
          ),
          loading: () => SliverToBoxAdapter(
            child: Platform.isIOS
                ? const Center(child: CupertinoActivityIndicator())
                : const Center(child: CircularProgressIndicator()),
          ),
        )
      ]),
      error: (error, stackTrace) => Text('Error: $error'),
      loading: () => Platform.isIOS
          ? const Center(child: CupertinoActivityIndicator())
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
