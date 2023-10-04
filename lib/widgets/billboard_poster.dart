import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:e_commerce/models/billboard.dart';

class BillboardPoster extends StatelessWidget {
  const BillboardPoster({super.key, required this.billboard});

  final Billboard billboard;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 5 / 3,
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(billboard.imageUrl),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: (deviceWidth - 20) * 0.75,
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Text(
                billboard.label,
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
                softWrap: true,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
