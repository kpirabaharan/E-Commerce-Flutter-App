import 'dart:io' show Platform;

import 'package:e_commerce/screens/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:e_commerce/actions/get_categories.dart';
import 'package:e_commerce/providers/active_store_provider.dart';

import 'package:e_commerce/widgets/main_drawer.dart';

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

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(getCategories);

    // Widget activePage = CategoryScreen();

    var activePageTitle = 'Featured';

    // if (_selectedPageIndex == 1) {
    //   final favoriteMeals = ref.watch(favoriteMealsProvider);
    //   activePage = MealsScreen(
    //     meals: favoriteMeals,
    //   );
    //   activePageTitle = 'Your Favorites';
    // }

    return categories.when(
      data: (categories) {
        final activeStore = ref.watch(activeStoreProvider);
        final categoryList = categories.map((category) => category).toList();
        return DefaultTabController(
          length: categoryList.length + 1,
          child: Scaffold(
            drawer: const MainDrawer(),
            appBar: activeStore != null
                ? AppBar(
                    title: Text(activeStore.name),
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primaryContainer,
                            Theme.of(context).colorScheme.primaryContainer.withAlpha(100),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: IconButton(
                          onPressed: () => {},
                          icon: Icon(
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
                                  onPressed: () => _selectPage(0), child: const Text('Featured'))),
                          ...categoryList
                              .mapIndexed((index, element) => Expanded(
                                  child: TextButton(
                                      onPressed: () => _selectPage(index + 1),
                                      child: Text(element.name))))
                              .toList()
                        ],
                      ),
                    ),
                  )
                : null,
            body: null,
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
