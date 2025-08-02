import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../../domain/entity/cart_entity.dart';
import 'container_animated.dart';

class CustomContainerWidget extends StatefulWidget {
  final CartEntity? cartEntity;
  final int? openedCartId;

  const CustomContainerWidget({
    super.key,
    required this.cartEntity,
    required this.openedCartId,
  });

  @override
  State<CustomContainerWidget> createState() => _CustomContainerWidgetState();
}

class _CustomContainerWidgetState extends State<CustomContainerWidget> {
  bool isExpanded = false;


  @override
  void initState() {
    super.initState();
    isExpanded = widget.cartEntity?.id == widget.openedCartId;
  }

  @override
  void didUpdateWidget(covariant CustomContainerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.openedCartId != oldWidget.openedCartId) {
      if (widget.cartEntity?.id == widget.openedCartId) {
        setState(() {
          isExpanded = true;
        });
      } else {
        setState(() {
          isExpanded = false;
        });
      }
    }
  }
  final AudioPlayer audioPlayer = AudioPlayer();
  Future<void> playClickSound() async {
    await audioPlayer.play(AssetSource('sound/pop_sound.mp3'));
  }
  @override
  Widget build(BuildContext context) {
    final bool isSkeleton = widget.cartEntity == null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isSkeleton ? Colors.grey.shade300 : const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isSkeleton
                        ? Container(
                            width: 80,
                            height: 16,
                            color: Colors.grey.shade400,
                          )
                        : Text(
                            "Cart  ${widget.cartEntity!.id.toString()}",
                            style: const TextStyle(fontSize: 16),
                          ),
                    isSkeleton
                        ? Container(
                            width: 24,
                            height: 24,
                            color: Colors.grey.shade400,
                          )
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                playClickSound();
                                isExpanded = !isExpanded;
                              });
                            },
                            icon: Icon(
                              isExpanded
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ),
                  ],
                ),
              ),
            ),

            // Body
            ContainerAnimatedWidget(
              isExpanded: isExpanded,
              isSkeleton: isSkeleton,
              widget: widget,
            ),
          ],
        ),
      ),
    );
  }
}

