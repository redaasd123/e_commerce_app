import 'package:e_commerce_app/core/utils/sevice_locator.dart';
import 'package:e_commerce_app/feature/home/presentation/manager/add_product/add_product_cubit.dart';
import 'package:e_commerce_app/feature/home/presentation/manager/delete_product/delete_product_cubit.dart';
import 'package:e_commerce_app/feature/home/presentation/manager/ecommerce_cubit.dart';
import 'package:e_commerce_app/feature/home/presentation/views/widget/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/image_product_cubit/image_cubit.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<DeleteProductCubit>()),
        BlocProvider(create: (context) => getIt.get<ImageProductCubit>()),
        BlocProvider(create: (context) => getIt.get<AddProductCubit>()),
        BlocProvider(create: (context) => getIt.get<EcommerceCubit>()..fetchProduct()),
      ],
      child: Scaffold(
        body: HomeViewBody(),
      ),
    );
  }
}
