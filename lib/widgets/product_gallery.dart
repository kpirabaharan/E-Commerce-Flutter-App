import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce/models/image.dart';

class ProductGallery extends StatefulWidget {
  const ProductGallery(
    this.productId,
    this.images, {
    super.key,
  });

  final String productId;
  final List<CustomImage> images;

  @override
  State<ProductGallery> createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<ProductGallery> {
  final PageController controller = PageController();
  var pageNumber = 0;

  void setPageNumber(int number) {
    setState(() {
      pageNumber = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.grey[300],
      height: height * 0.5,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (page) => setPageNumber(page),
            controller: controller,
            children: widget.images
                .mapIndexed((index, image) => index == 0
                    ? Hero(
                        tag: widget.productId,
                        child: Image.network(image.url),
                      )
                    : Image.network(image.url))
                .toList(),
          ),
          Positioned(
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...widget.images
                    .mapIndexed((index, _) => Container(
                          height: 2,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: pageNumber == index ? Colors.black : Colors.grey[400],
                          ),
                        ))
                    .toList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
