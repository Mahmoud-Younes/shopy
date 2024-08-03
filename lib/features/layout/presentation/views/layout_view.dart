import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy/core/utils/function/service_locator.dart';
import 'package:shopy/features/layout/data/repo/cart/cart_repo_impl.dart';
import 'package:shopy/features/layout/data/repo/favorites/favorites_repo_impl.dart';
import 'package:shopy/features/layout/data/repo/home_repo/home_repo_impl.dart';
import 'package:shopy/features/layout/presentation/views/widget/layout_body.dart';
import '../../data/repo/user_repo/user_repo_impl.dart';
import '../manager/layout_cubit.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(
        getIT<UserRepoImpl>(),
        getIT<HomeRepoImpl>(),
        getIT<FavoritesRepoImpl>(),
        getIT<CartRepoImpl>(),
      )
        ..getHome()
        ..getCategory()
        ..getfavorites()
        ..getcart(),
      child: const Scaffold(
        body: LayoutBody(),
      ),
    );
  }
}
