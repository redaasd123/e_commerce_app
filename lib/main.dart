import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce_app/core/connectivity/check_internet_cubit.dart';
import 'package:e_commerce_app/core/utils/app_router.dart';
import 'package:e_commerce_app/core/utils/constance..dart';
import 'package:e_commerce_app/feature/home/domain/entity/cart_entity/cart_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/utils/sevice_locator.dart';
import 'feature/home/domain/entity/product_entity/product_entity.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ProductEntityAdapter());
  Hive.registerAdapter(CartEntityAdapter());

 await Hive.deleteBoxFromDisk(kCatBox);
  await Hive.openBox<CartEntity>(kCatBox);
  setUpServiceLocator();
  runApp(EcommerceApp());
}


class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckInternetCubit(
        getIt<Connectivity>(),
        getIt<InternetConnectionChecker>(),
      ),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
