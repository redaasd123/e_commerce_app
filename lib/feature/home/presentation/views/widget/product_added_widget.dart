
import 'package:flutter/cupertino.dart';

import '../../../../../core/utils/styles.dart';
import '../../../domain/entity/image_entity.dart';
import 'circlerAvatar_lis_view.dart';

class ProductAddedWidget extends StatelessWidget {
  const ProductAddedWidget({
    super.key,
    required this.imageList,
  });

  final List<ImageEntity> imageList;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: imageList.isNotEmpty
          ? const SizedBox(
        key: ValueKey('circle_list'),
        height: 100,
        child: CircleAvatarLisView(),
      )
          : const Padding(
        key: ValueKey('empty_state'),
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            'add product here....',
            style: Styles.textStyle14,
          ),
        ),
      ),
    );
  }
}