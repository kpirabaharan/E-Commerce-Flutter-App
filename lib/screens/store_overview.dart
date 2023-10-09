import 'dart:io' show Platform;

import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/widgets/filter_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/actions/get_categories.dart';
import 'package:e_commerce/providers/active_store_provider.dart';
import 'package:e_commerce/providers/category_provider.dart';

import 'package:e_commerce/screens/category.dart';

import 'package:e_commerce/widgets/main_drawer.dart';
import 'package:e_commerce/screens/cart.dart';

class StoreOverviewScreen extends ConsumerStatefulWidget {
  const StoreOverviewScreen({super.key});
  static const routeName = '/store-overview';

  @override
  ConsumerState<StoreOverviewScreen> createState() {
    return _StoreOverviewScreen();
  }
}

class _StoreOverviewScreen extends ConsumerState<StoreOverviewScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index, Category? category) {
    _selectedPageIndex = index;
    setState(() {
      if (category != null) {
        ref.watch(categoryProvider.notifier).setActiveCategory(category);
      } else {
        ref.watch(categoryProvider.notifier).clearActiveCategory();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(getCategories);
    final activeStore = ref.watch(activeStoreProvider);
    final cartTotalItems = ref
        .watch(cartProvider)
        .where((item) => item.storeId == activeStore!.id)
        .fold<int>(0, (previousValue, element) => previousValue + element.quantity);

    return categories.when(
      data: (categories) {
        return DefaultTabController(
          length: categories.length + 1,
          child: Scaffold(
            endDrawer: const FilterDrawer(),
            drawer: const MainDrawer(),
            appBar: activeStore != null
                ? AppBar(
                    title: Text(activeStore.name),
                    flexibleSpace: Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    actions: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pushNamed(CartScreen.routeName),
                        icon: Badge(
                          // backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                          // textColor: Theme.of(context).colorScheme.secondary,
                          label: Text(cartTotalItems.toString()),
                          child: Icon(
                              Platform.isIOS ? CupertinoIcons.cart : Icons.shopping_cart_outlined),
                        ),
                      )
                    ],
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(50),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => _selectPage(0, null),
                              child: Text(
                                'Featured',
                                style: _selectedPageIndex == 0
                                    ? Theme.of(context).textTheme.bodyLarge
                                    : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                              ),
                            ),
                          ),
                          ...categories
                              .mapIndexed(
                                (index, element) => Expanded(
                                  child: TextButton(
                                    onPressed: () => _selectPage(index + 1, element),
                                    child: Text(
                                      element.name,
                                      style: _selectedPageIndex == index + 1
                                          ? Theme.of(context).textTheme.bodyLarge
                                          : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                    ),
                                  ),
                                ),
                              )
                              .toList()
                        ],
                      ),
                    ),
                  )
                : null,
            body: const CategoryScreen(),
          ),
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => Platform.isIOS
          ? const Center(child: CupertinoActivityIndicator())
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
