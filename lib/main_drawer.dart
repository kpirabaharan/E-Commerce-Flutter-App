import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buildListTile(String title, VoidCallback tapHandler, {dynamic icon = Icons.shopping_bag}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.primaryContainer.withAlpha(100),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.store,
                  size: 48,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 18),
                Text(
                  'Stores',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          buildListTile('Clothes', () => {}, icon: Ionicons.shirt),
          buildListTile('Shoes', () => {}),
        ],
      ),
    );
  }
}
