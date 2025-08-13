import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../domain/entity/cart_entity/cart_entity.dart';
import '../../manager/ecommerce_cubit.dart';
import 'custom_container_widget.dart';

SliverList ContainerSLiverList(
    List<CartEntity> products,
    EcommerceSuccessState state,
    ) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
          (context, index) {
        if (index < products.length) {
          return CustomContainerWidget(
              openedCartId: context.read<EcommerceCubit>().openedCartId,
              cartEntity: products[index]);
        } else {
          return state.hasReachedEnd
              ? const Center(child: Text('لا توجد مزيد من المنتجات'))
              : const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SpinKitFadingCircle(
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Loading...',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }


          },
      childCount: state.hasReachedEnd ? products.length : products.length + 1,
    ),
  );
}