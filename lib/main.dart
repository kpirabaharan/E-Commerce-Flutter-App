import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:e_commerce/screens/home.dart';
import 'package:e_commerce/screens/store_overview.dart';
import 'package:e_commerce/screens/cart.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 49, 9, 77),
  ),
  textTheme: GoogleFonts.latoTextTheme().apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
    decorationColor: Colors.white,
  ),
);

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce MultiStore Mobile App',
      home: const HomeScreen(),
      routes: {
        StoreOverviewScreen.routeName: (ctx) => const StoreOverviewScreen(),
        CartScreen.routeName: (ctx) => const CartScreen(),
      },
    );
  }
}
