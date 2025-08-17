import 'package:e_commerce_app/feature/home/domain/entity/cart_entity/cart_entity.dart';
import 'package:e_commerce_app/feature/home/presentation/manager/ecommerce_cubit.dart';
import 'package:e_commerce_app/feature/home/presentation/views/widget/detail_container_drop_down.dart';
import 'package:e_commerce_app/feature/home/presentation/views/widget/param/add_product_param.dart';
import 'package:e_commerce_app/feature/home/presentation/views/widget/param/delete_product_param.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/image_product_cubit/image_cubit.dart';

class DetailContainerListView extends StatelessWidget {
  const DetailContainerListView({super.key, required this.cartEntity});

  final CartEntity cartEntity;

  @override
  Widget build(BuildContext context) {
    final imageCubit = context.watch<ImageProductCubit>();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartEntity.products.length,
      itemBuilder: (context, index) {
        final product = cartEntity.products[index];
        final AddProductparam = AddProductParam(
          cartId: cartEntity.id,
          products: [product],
        );
        final deleteProductParam = DeleteProductParam(
          id: cartEntity.id,
          product: [product],
        );
        final isAdded = imageCubit.state.any(
          (img) => img.imageUrl == product.thumbnail,
        );
        return DetailContainerDropDown(
          cartEntity: cartEntity,
          imageUrl: product.thumbnail,
          description: product.title,
          onPressed: () {
            if (isAdded) {
              //BlocProvider.of<EcommerceCubit>(context).deleteProduct(deleteProductParam);
              context.read<ImageProductCubit>().removeImageByUrl(product.thumbnail);
            }else {
             // BlocProvider.of<EcommerceCubit>(context).addProduct(AddProductparam);
              context.read<ImageProductCubit>().addImage(
                product.thumbnail,
                product.price,
              );
            }
          },
          isAdded: isAdded,
        );
      },
    );
  }
}
