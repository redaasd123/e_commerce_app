import 'package:e_commerce_app/core/connectivity/check_internet_cubit.dart';
import 'package:e_commerce_app/core/utils/show_snack_bar.dart';
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
  bool _firstCheck = true;

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
    return BlocListener<CheckInternetCubit, CheckInternetState>(
      listener: (context, state) async {
        if (_firstCheck) {
          _firstCheck = false;
          return;
        }

        if (state is ConnectivityDisconnected) {
          showSnackBar(context, 'No Internet Connection!', Colors.red);
        } else if (state is ConnectivityConnected) {
          await BlocProvider.of<EcommerceCubit>(context).fetchProduct();
          showSnackBar(context, 'Back Online!', Colors.green);
        }
      },
      child: BlocBuilder<CheckInternetCubit, CheckInternetState>(
        builder: (context, state) {
          if (state is ConnectivityConnected) {
            return RefreshIndicator(
              onRefresh: () async {
                await BlocProvider.of<EcommerceCubit>(context).fetchProduct();
              },
              child: HomeViewBodyItem(
                scrollController: _scrollController,
                imageList: imageList,
              ),
            );
          } else if (state is ConnectivityDisconnected) {
            return HomeViewBodyItem(
              scrollController: _scrollController,
              imageList: imageList,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
