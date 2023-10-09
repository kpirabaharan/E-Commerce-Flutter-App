import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/providers/active_fliters_provider.dart';
import 'package:e_commerce/actions/get_colors.dart';
import 'package:e_commerce/actions/get_sizes.dart';

import 'package:e_commerce/widgets/filter_list.dart';

class FilterDrawer extends ConsumerStatefulWidget {
  const FilterDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends ConsumerState<FilterDrawer> {
  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(getColors);
    final sizes = ref.watch(getSizes);

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.primaryContainer.withAlpha(100),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.filter_alt_outlined,
                  size: 48,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 18),
                Text(
                  'Filters',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: Row(children: [
              const Spacer(),
              FilledButton.tonal(
                onPressed: () => ref.read(activeFiltersProvider.notifier).clearActiveFilters(),
                child: const Text('Clear Filters'),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              'Colors',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          FilterList(
            filters: colors,
            onClick: ref.read(activeFiltersProvider.notifier).setActiveFilter,
            filterKey: 'color',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              'Sizes',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          FilterList(
            filters: sizes,
            onClick: ref.read(activeFiltersProvider.notifier).setActiveFilter,
            filterKey: 'size',
          ),
        ],
      ),
    );
  }
}
