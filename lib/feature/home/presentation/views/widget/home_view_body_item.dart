import 'package:e_commerce_app/feature/home/presentation/views/widget/product_added_widget.dart';
import 'package:e_commerce_app/feature/home/presentation/views/widget/skeltonizer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/image_entity.dart';
import '../../manager/ecommerce_cubit.dart';
import 'container_sliver_list.dart';
import 'custom_text_field.dart';

class HomeViewBodyItem extends StatelessWidget {
  const HomeViewBodyItem({
    super.key,
    required ScrollController scrollController,
    required this.imageList,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<ImageEntity> imageList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              ProductAddedWidget(imageList: imageList),
              CustomSearchTextField(
                onChanged: (value) {
                  BlocProvider.of<EcommerceCubit>(context).searchProduct(value);
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              BlocBuilder<EcommerceCubit, EcommerceState>(
                builder: (context, state) {
                  if (state is EcommerceSuccessState) {
                    final products = state.cart;

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      final cubit = context.read<EcommerceCubit>();
                      final index = cubit.scrollToCartIndex;
                      if (index != null) {
                        _scrollController.animateTo(
                          index * 300.0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    });

                    return ContainerSLiverList(products, state);
                  } else if (state is EcommerceFailureState) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Column(
                          children: [
                            Text('Error: ${state.errMessage}'),
                            ElevatedButton(
                              onPressed: () =>
                                  context.read<EcommerceCubit>().fetchProduct(),
                              child: const Text('Try Again'),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return SkeletonizerWidget();
                      }, childCount: 6),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
