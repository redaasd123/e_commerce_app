import 'package:e_commerce_app/core/utils/styles.dart';
import 'package:e_commerce_app/feature/home/domain/entity/cart_entity.dart';
import 'package:e_commerce_app/feature/home/presentation/views/widget/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/utils/styles.dart';
import 'package:e_commerce_app/feature/home/domain/entity/cart_entity.dart';
import 'package:e_commerce_app/feature/home/presentation/views/widget/custom_button.dart';
import 'package:flutter/material.dart';

class DetailContainerDropDown extends StatelessWidget {
  const DetailContainerDropDown({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.cartEntity,
    required this.onPressed,
    required this.isAdded,
  });

  final String imageUrl;
  final String description;
  final CartEntity cartEntity;
  final VoidCallback onPressed;
  final bool isAdded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(imageUrl),
              ),
              const Spacer(),
              CustomButton(
                color: isAdded ? Colors.red : Colors.blueGrey,
                text: isAdded ? 'Remove' : 'Add',
                onPressed: onPressed,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Styles.textStyle16,
          ),
        ],
      ),
    );
  }
}


