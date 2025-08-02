import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    required this.imageUrl,
    required this.price, required this.onTap,
  });

  final String imageUrl;
  final num price;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 32.5,
          backgroundImage: NetworkImage(imageUrl),
        ),
        Positioned(
          top: -5,
          right: -5,
            child: GestureDetector(
              onTap: onTap,
              child: const Icon(
                Icons.close,
                size: 18,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );

  }
}
