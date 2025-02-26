import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const ImageCard({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 3,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          fadeInDuration: Duration.zero,
          fadeOutDuration: Duration.zero,
          placeholder: (context, url) => Container(),
          errorWidget:
              (context, url, error) =>
                  const Icon(Icons.error_outline, color: Colors.red, size: 30),
        ),
      ),
    );
  }
}
