import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageFromUrl extends StatelessWidget {
  final String? imageUrl;

  const ImageFromUrl({Key? key,this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return const Icon(Icons.broken_image);
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      );
    }

  }
}
