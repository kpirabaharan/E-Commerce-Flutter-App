import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/actions/get_products.dart';
import 'package:e_commerce/actions/get_billboard.dart';

import 'package:e_commerce/widgets/product_item.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billboard = ref.watch(getBillboard);
    final products = ref.watch(getProducts);
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return billboard.when(
      data: (billboard) => CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          expandedHeight: 250.0,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.filter_alt_outlined),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(billboard.label),
            background: Image.network(billboard.imageUrl, fit: BoxFit.cover),
          ),
        ),
        products.when(
          data: (products) => SliverPadding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, bottomInset),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
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
