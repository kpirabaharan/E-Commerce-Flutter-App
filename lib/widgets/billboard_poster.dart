import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:e_commerce/models/billboard.dart';

class BillboardPoster extends StatelessWidget {
  const BillboardPoster({super.key, required this.billboard});

  final Billboard billboard;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: AspectRatio(
        aspectRatio: 5 / 3,
        child: FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: NetworkImage(billboard.imageUrl),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
