import 'package:e_commerce/providers/active_fliters_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterList extends ConsumerStatefulWidget {
  const FilterList({
    Key? key,
    required this.filters,
    required this.onClick,
    required this.filterKey,
  }) : super(key: key);

  final AsyncValue<List<dynamic>> filters;
  final void Function(String key, dynamic color) onClick;
  final String filterKey;

  @override
  ConsumerState<FilterList> createState() => _FilterListState();
}

class _FilterListState extends ConsumerState<FilterList> {
  @override
  Widget build(BuildContext context) {
    return widget.filters.when(
      data: (filters) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: 100,
          child: Wrap(
            spacing: 10,
            children: filters
                .map(
                  (filter) => FilterChip(
                    label: Text(filter.name),
                    onSelected: (isSelected) => setState(() {
                      isSelected
                          ? widget.onClick(widget.filterKey, filter)
                          : widget.onClick(widget.filterKey, null);
                    }),
                    selected: ref.watch(activeFiltersProvider)[widget.filterKey]?.id == filter.id,
                  ),
                )
                .toList(),
          ),
        ),
      ),
      error: (err, s) => Text(err.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
