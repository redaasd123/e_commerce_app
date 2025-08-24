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

    return MultiBlocListener(
      listeners: [
        // 🔌 Listener بتاع الإنترنت
        BlocListener<CheckInternetCubit, CheckInternetState>(
          listener: (context, state) async {
            if (_firstCheck) {
              _firstCheck = false;
              return;
            }

            if (state is ConnectivityDisconnected) {
              showSnackBar(context, 'No Internet Connection!', Colors.red);
            }
            if (state is ConnectivityConnected) {
              showSnackBar(context, 'Internet Connected, refreshing...', Colors.green);
              await context.read<EcommerceCubit>().fetchProduct(refresh: true);
            }
          },
        ),

        // 📡 Listener بتاع EcommerceCubit
        BlocListener<EcommerceCubit, EcommerceState>(
          listener: (context, state) {
             if (state is EcommerceFailureState) {
              showSnackBar(context, state.errMessage, Colors.red);
            }
          },
        ),
      ],
      child: BlocBuilder<EcommerceCubit, EcommerceState>(
        builder: (context, state) {
          if (state is EcommerceLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EcommerceSuccessState) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<EcommerceCubit>().fetchProduct(refresh: true);
              },
              child: HomeViewBodyItem(
                scrollController: _scrollController,
                imageList: imageList,
              ),
            );
          } else if (state is EcommerceFailureState) {
            return Center(child: Text(state.errMessage));
          } else if (state is EcommerceOfflineState) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<EcommerceCubit>().fetchProduct(refresh: true);
              },
              child: HomeViewBodyItem(
                scrollController: _scrollController,
                imageList: imageList,
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
