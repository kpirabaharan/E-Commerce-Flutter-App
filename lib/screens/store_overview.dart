import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:e_commerce/widgets/main_drawer.dart';

class StoreOverviewPage extends StatelessWidget {
  const StoreOverviewPage({super.key});
  static const routeName = '/store-overview';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const MainDrawer(),
        appBar: AppBar(
          title: const Text('E-Commerce'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () => {},
                icon: Icon(Platform.isIOS ? CupertinoIcons.cart : Icons.shopping_cart_outlined),
              ),
            )
          ],
          bottom: const TabBar(
            isScrollable: false,
            tabAlignment: TabAlignment.fill,
            tabs: [
              Tab(child: Text('Shirts')),
              Tab(child: Text('Jeans')),
            ],
          ),
        ),
        body: const Center(
          child: Text('E-Commerce Store App'),
        ),
      ),
    );
  }
}
