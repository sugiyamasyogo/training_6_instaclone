import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  final Image image;
  final VoidCallback? onTap;


  const HeroImage({Key? key, required this.image, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: "postImage",
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: image,
          ),
        )
    );
  }
}
