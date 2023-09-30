import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_drawer.dart';

void main() => runApp(const MyApp());

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 49, 9, 77),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce MultiStore Mobile App',
      home: DefaultTabController(
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
      ),
    );
  }
}
