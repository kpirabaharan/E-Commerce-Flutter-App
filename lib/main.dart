import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
              .copyWith(secondary: Colors.amber),
          useMaterial3: true),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('E-Commerce'),
            actions: [
              IconButton(
                onPressed: () => {},
                icon: const Icon(Iconsax.sun_15),
              ),
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.shopping_cart_sharp),
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
      ),
    );
  }
}
