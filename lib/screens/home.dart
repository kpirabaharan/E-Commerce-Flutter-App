import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/models/store.dart';
import 'package:e_commerce/actions/get_stores.dart';
import 'package:e_commerce/providers/active_store_provider.dart';

import 'package:e_commerce/screens/store_overview.dart';

import 'package:e_commerce/widgets/store_selector_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _selectStore(BuildContext context, Store store, WidgetRef ref) {
    ref.read(activeStoreProvider.notifier).setActiveStore(store);
    Navigator.of(context).pushNamed(StoreOverviewScreen.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stores = ref.watch(getStores);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('E-Commerce Mobile App'),
      ),
      body: stores.when(
        data: (stores) => GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            ...stores
                .map((store) => StoreSelectorItem(
                      store: store,
                      onSelectStore: () => _selectStore(context, store, ref),
                    ))
                .toList()
          ],
        ),
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => Platform.isIOS
            ? const Center(child: CupertinoActivityIndicator())
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
