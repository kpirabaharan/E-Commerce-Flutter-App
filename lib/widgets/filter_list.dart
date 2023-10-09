import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterList extends ConsumerStatefulWidget {
  const FilterList({
    Key? key,
    required this.filters,
    required this.onClick,
    required this.activeFilter,
  }) : super(key: key);

  final AsyncValue<List<dynamic>> filters;
  final void Function(dynamic color) onClick;
  final dynamic activeFilter;

  @override
  ConsumerState<FilterList> createState() => _FilterListState();
}

class _FilterListState extends ConsumerState<FilterList> {
  @override
  Widget build(BuildContext context) {
    print(widget.activeFilter?.name);
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
                      widget.onClick(filter);
                    }),
                    selected: widget.activeFilter?.id == filter.id,
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
