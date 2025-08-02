import 'package:e_commerce_app/feature/home/presentation/manager/ecommerce_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/image_product_cubit/image_cubit.dart';
import 'home_view_body_item.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    context.read<EcommerceCubit>().fetchProduct();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final cubit = context.read<EcommerceCubit>();
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !cubit.isLoading &&
        !cubit.hasReachedEnd) {
      cubit.fetchProduct();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageList = context.watch<ImageProductCubit>().state;
    return HomeViewBodyItem(scrollController: _scrollController, imageList: imageList);
  }


}


