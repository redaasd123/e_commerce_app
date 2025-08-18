import 'package:e_commerce_app/core/connectivity/check_internet_cubit.dart';
import 'package:e_commerce_app/core/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/image_product_cubit/image_cubit.dart';
import 'detail_container_drop_down.dart';
import '../../../domain/entity/cart_entity/cart_entity.dart';

class DetailContainerListView extends StatelessWidget {
  const DetailContainerListView({super.key, required this.cartEntity});

  final CartEntity cartEntity;

  @override
  Widget build(BuildContext context) {
    final imageCubit = context.watch<ImageProductCubit>();
    final isConnected = context.watch<CheckInternetCubit>().state
    is ConnectivityConnected;

    return Column(
      children: [
        BlocBuilder<CheckInternetCubit, CheckInternetState>(
          builder: (context, internetState) {
            if (internetState is ConnectivityDisconnected) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "⚠️ لا يوجد اتصال بالإنترنت",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cartEntity.products.length,
          itemBuilder: (context, index) {
            final product = cartEntity.products[index];
            final isAdded = imageCubit.state.any(
                  (img) => img.imageUrl == product.thumbnail,
            );

            return DetailContainerDropDown(
              cartEntity: cartEntity,
              imageUrl: product.thumbnail,
              description: product.title,
              isAdded: isAdded,
              onPressed: () {
                if (!isConnected) {

                showSnackBar(context, 'No Internet Connection', Colors.red);
                  return;
                }

                if (isAdded) {
                  context.read<ImageProductCubit>().removeImageByUrl(
                    product.thumbnail,
                  );
                } else {
                  context.read<ImageProductCubit>().addImage(
                    product.thumbnail,
                    product.price,
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
