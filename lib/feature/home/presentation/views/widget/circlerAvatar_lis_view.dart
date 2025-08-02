import 'package:e_commerce_app/feature/home/presentation/manager/ecommerce_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/image_product_cubit/image_cubit.dart';
import 'custom_circler_avater.dart';

class CircleAvatarLisView extends StatelessWidget {
  const CircleAvatarLisView({super.key});

  @override
  Widget build(BuildContext context) {
    final imageList = context.watch<ImageProductCubit>().state;
    return BlocListener<EcommerceCubit, EcommerceState>(
      listener: (context, state) {
        if (state is EcommerceSuccessState) {
          state.cart;
        }
      },
      child: SizedBox(
        height: 80,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            final imageModel = imageList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomCircleAvatar(
                onTap: () {
                  context.read<ImageProductCubit>().removeImageByUrl(
                    imageModel.imageUrl,
                  );
                },
                price: imageModel.price,
                imageUrl: imageModel.imageUrl,
              ),
            );
          },
        ),
      ),
    );
  }
}
