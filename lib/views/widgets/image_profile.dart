import 'package:flutter/material.dart';

class ImageProfile extends StatelessWidget {
  final String image;
  final double radius;
  const ImageProfile({required this.image, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(image),
    );
  }
}
