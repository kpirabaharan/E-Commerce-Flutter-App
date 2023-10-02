import 'package:e_commerce/screens/store_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:e_commerce/screens/home_page.dart';

Future main() async {
  await dotenv.load();
  runApp(const ProviderScope(child: MyApp()));
}

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
      home: const HomePage(),
      routes: {
        StoreOverviewPage.routeName: (ctx) => const StoreOverviewPage(),
      },
    );
  }
}
