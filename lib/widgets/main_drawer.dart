import 'package:e_commerce/providers/active_category_provider.dart';
import 'package:e_commerce/providers/stores_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/store.dart';

import 'package:e_commerce/providers/active_store_provider.dart';

import 'package:e_commerce/screens/store_overview.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  Widget buildListTile(String title, VoidCallback tapHandler, {dynamic icon = Icons.shopping_bag}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  void _selectStore(BuildContext context, Store store, WidgetRef ref) {
    ref.read(activeStoreProvider.notifier).setActiveStore(store);
    ref.read(categoryProvider.notifier).clearActiveCategory();
    Navigator.of(context).pushReplacementNamed(StoreOverviewScreen.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stores = ref.watch(storesProvider);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
            child: Row(
              children: [
                Icon(
                  Icons.store,
                  size: 48,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 18),
                Text(
                  'Stores',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          stores.when(
            data: (stores) {
              return Column(
                children: stores
                    .map(
                      (store) => buildListTile(
                        store.name,
                        () => _selectStore(context, store, ref),
                      ),
                    )
                    .toList(),
              );
            },
            error: (err, s) => Text(err.toString()),
            loading: () => const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
