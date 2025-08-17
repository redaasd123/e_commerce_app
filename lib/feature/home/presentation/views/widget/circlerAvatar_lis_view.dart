import 'package:e_commerce_app/core/utils/show_snack_bar.dart';
import 'package:e_commerce_app/feature/home/presentation/manager/ecommerce_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/connectivity/check_internet_cubit.dart';
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
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            final imageModel = imageList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomCircleAvatar(
                  onTap: () {
                    final state = context.read<CheckInternetCubit>().state;

                    if (state is ConnectivityConnected) {
                      context.read<ImageProductCubit>().removeImageByUrl(
                        imageModel.imageUrl,
                      );
                    } else {
                     showSnackBar(context, 'No internet connection', Colors.red);
                    }

                  },
                  price: imageModel.price,
                  imageUrl: imageModel.imageUrl,
                ),

            );
          },
        ),

    );
  }
}
