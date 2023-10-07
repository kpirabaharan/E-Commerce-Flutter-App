import 'package:flutter/material.dart';

import 'package:e_commerce/models/store.dart';

class StoreSelectorItem extends StatelessWidget {
  const StoreSelectorItem({super.key, required this.store, required this.onSelectStore});

  final Store store;
  final void Function() onSelectStore;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectStore,
      borderRadius: BorderRadius.circular(16),
      splashColor: Theme.of(context).canvasColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withAlpha(200),
                Theme.of(context).colorScheme.primary.withAlpha(100),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Center(
          child: Text(store.name, style: Theme.of(context).textTheme.titleLarge),
        ),
      ),
    );
  }
}
