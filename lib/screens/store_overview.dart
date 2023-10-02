import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:e_commerce/actions/get_categories.dart';
import 'package:e_commerce/providers/stores_provider.dart';

import 'package:e_commerce/widgets/main_drawer.dart';

class StoreOverviewPage extends ConsumerWidget {
  const StoreOverviewPage({super.key});
  static const routeName = '/store-overview';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(getCategories);

    return categories.when(
      data: (categories) {
        final activeStore = ref.watch(storesProvider).activeStore;
        final categoryList = categories.map((category) => category).toList();
        return DefaultTabController(
            length: categoryList.length,
            child: Scaffold(
              drawer: const MainDrawer(),
              appBar: AppBar(
                title: Text(activeStore.name),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: IconButton(
                      onPressed: () => {},
                      icon:
                          Icon(Platform.isIOS ? CupertinoIcons.cart : Icons.shopping_cart_outlined),
                    ),
                  )
                ],
                bottom: TabBar(
                  isScrollable: false,
                  tabAlignment: TabAlignment.fill,
                  tabs: [...categoryList.map((element) => Tab(text: element.name)).toList()],
                ),
              ),
              body: const Center(
                child: Text('E-Commerce Store App'),
              ),
            ));
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => Platform.isIOS
          ? const CupertinoActivityIndicator()
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
