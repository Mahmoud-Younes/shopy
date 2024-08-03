import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:shopy/features/auth/data/repo/auth_repo_impl.dart';
import 'package:shopy/features/layout/data/repo/cart/cart_repo_impl.dart';
import 'package:shopy/features/layout/data/repo/favorites/favorites_repo_impl.dart';
import '../../../features/layout/data/repo/home_repo/home_repo_impl.dart';
import '../../../features/layout/data/repo/user_repo/user_repo_impl.dart';
import 'api_service.dart';

final getIT = GetIt.instance;

class ServiceLocater {
  void setupServiceLocator() {
    getIT.registerSingleton<ApiService>(ApiService(Dio()));
    getIT.registerSingleton<AuthRepoImpl>(AuthRepoImpl(getIT()));
    getIT.registerSingleton<HomeRepoImpl>(HomeRepoImpl(
      getIT.get<ApiService>(),
    ));
    // getIT.registerSingleton<HomeRepoImpl>(HomeRepoImpl(getIT()));
    getIT.registerSingleton<UserRepoImpl>(UserRepoImpl(
      getIT.get<ApiService>(),
    ));
    getIT.registerSingleton<FavoritesRepoImpl>(FavoritesRepoImpl(
      getIT.get<ApiService>(),
    ));
    getIT.registerSingleton<CartRepoImpl>(CartRepoImpl(
      getIT.get<ApiService>(),
    ));
    //getIT.registerLazySingleton<FavoritesRepoImpl>(FavoritesRepoImpl(
    //   getIT.get<ApiService>(),
    // ) as FactoryFunc<FavoritesRepoImpl>);
    // getIT.registerSingletonAsync<CartRepoImpl>(CartRepoImpl(
    //   getIT.get<ApiService>(),
    // ) as FactoryFuncAsync<CartRepoImpl>);
  }
}
