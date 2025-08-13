
import 'package:flutter/cupertino.dart';

import 'custom_container_widget.dart';
import 'detail_container_list_view.dart';

class ContainerAnimatedWidget extends StatelessWidget {
  const ContainerAnimatedWidget({
    super.key,
    required this.isExpanded,
    required this.isSkeleton,
    required this.widget,
  });

  final bool isExpanded;
  final bool isSkeleton;
  final CustomContainerWidget widget;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0.0, -0.1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: isExpanded && !isSkeleton
          ? Column(
              key: const ValueKey('Expanded'),
              children: [
                DetailContainerListView(cartEntity: widget.cartEntity!),
                const SizedBox(height: 8),
              ],
            )
          : const SizedBox.shrink(key: ValueKey('Collapsed')),
    );
  }
}
