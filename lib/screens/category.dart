import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce/actions/get_billboard.dart';

import 'package:e_commerce/widgets/billboard_poster.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billboard = ref.watch(getBillboard);

    return billboard.when(
      skipLoadingOnReload: true,
      data: (billboard) => Column(
        children: [
          BillboardPoster(billboard: billboard),
        ],
      ),
      error: (error, stackTrace) => Text('Error: $error'),
      loading: () => Platform.isIOS
          ? const Center(child: CupertinoActivityIndicator())
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
