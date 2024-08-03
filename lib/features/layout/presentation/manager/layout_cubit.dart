import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy/features/layout/data/model/favorites.dart';
import 'package:shopy/features/layout/data/model/home.dart';
import 'package:shopy/features/layout/data/repo/cart/cart_repo.dart';
import 'package:shopy/features/layout/data/repo/user_repo/user_repo.dart';
import 'package:shopy/features/layout/presentation/views/cart/cart_view.dart';
import 'package:shopy/features/layout/presentation/views/categories/categories_view.dart';
import '../../../../constants.dart';
import '../../../../core/utils/function/cacheNetwork.dart';
import '../../../auth/data/model/user_model.dart';
import 'package:flutter/material.dart';
import '../../data/model/cart.dart';
import '../../data/model/category_model.dart';
import '../../data/repo/favorites/favorites_repo.dart';
import '../../data/repo/home_repo/home_repo.dart';
import '../views/favorites/favorites.dart';
import '../views/home/home.dart';
import '../views/profile/profile_view.dart';
part 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit(
    this.uuserRepoo,
    this.homeRebo,
    this.favoritesRepo,
    this.cartRepo,
  ) : super(LayoutInitialState());

  int bottomNavIndex = 0;
  List<Widget> layoutScreens = [
    HomeScreen(),
    const CategoriesView(),
    const FavoritesView(),
    const CartView(),
    const ProfileView(),
  ];
  void changeBottomNavIndex({required int index}) {
    bottomNavIndex = index;
    // Emit state
    emit(ChangeBottomNavIndexState());
  }

  UserRepo uuserRepoo;
  Future<void> getProfile() async {
    emit(AnyThingLoading());
    var result = await uuserRepoo.getProfile();
    result.fold(
      (l) {
        emit(ProfileFailure(l.errMessage));
      },
      (r) {
        emit(ProfileSuccess(r));
      },
    );
  }

  //get banner and product
  HomeRepo homeRebo;
  // List<HomeModel> products = [];
  // List<HomeModel> banners = [];
  Future<void> getHome() async {
    emit(AnyThingLoading());
    var result = await homeRebo.getHome();
    result.fold(
      (l) {
        emit(HomeFailure(l.errMessage));
      },
      (r) {
        // banners
        //     .add(HomeModel.fromJson(r.data!.banners! as Map<String, dynamic>));
        // products
        //     .add(HomeModel.fromJson(r.data!.products! as Map<String, dynamic>));
        emit(HomeSuccess(r));
      },
    );
  }

  // List<CategoryModel> categories = [];
  Future<void> getCategory() async {
    emit(AnyThingLoading());
    var result = await homeRebo.getCategory();

    result.fold(
      (l) {
        emit(CategoryFailure(l.errMessage));
      },
      (r) {
        // categories.add(CategoryModel.fromJson(r as Map<String, dynamic>));
        emit(CategorySuccess(r));
      },
    );
  }

  // //filtered products
  // List<HomeModel> filteredProducts = [];
  // void filterProducts({required String input}) {
  //   filteredProducts = products
  //       .where((element) => element.data!.products!.any((product) =>
  //           product.name!.toLowerCase().startsWith(input.toLowerCase())))
  //       .toList();
  //   emit(FilterProductsSuccess());
  // }

  FavoritesRepo favoritesRepo;
  // set مفيش تكرار
  // Set<String> favoritesID = {};
  List<FavoritesModel> favorites = [];
  Future<void> getfavorites() async {
    // favoritesID.clear();
    emit(AnyThingLoading());
    var result = await favoritesRepo.getfavorites();

    result.fold(
      (l) {
        emit(FavoritesFailure(l.errMessage));
      },
      (r) {
        // favoritesID.addAll(r.map((favorite) => favorite.data!.data.toString()));

        // for (var item in r.data?.data ?? []) {
        //   favoritesID.add(item.product!.id!.toString());
        //   print(item.product!.id!.toString());
        //   log(item.product!.id!.toString());
        //   favorites.add(item.product!);
        // }

        //  favoritesID.add(r.data!.data![index].product!.id!.toString());
        emit(FavoritesSuccess(r));
      },
    );
  }

  Future<void> postfavorites({
    required String productID,
  }) async {
    emit(AnyThingLoading());
    var result = await favoritesRepo.postfavorites(
      productID: productID,
    );
    result.fold(
      (l) {
        emit(PostFavoritesFailure(l.errMessage));
      },
      (r) {
        emit(PostFavoritesSuccess(r));
      },
    );
  }

  CartRepo cartRepo;
  Future<void> getcart() async {
    emit(AnyThingLoading());
    var result = await cartRepo.getcart();
    result.fold(
      (l) {
        emit(CartFailure(l.errMessage));
      },
      (r) {
        emit(CartSuccess(r));
      },
    );
  }

  Future<void> changePassword({
    required String userCurrentPassword,
    required String newPassword,
  }) async {
    emit(AnyThingLoading());

    var result = await uuserRepoo.changePassword(
      userCurrentPassword: userCurrentPassword,
      newPassword: newPassword,
    );

    result.fold((failure) {
      emit(ChangePasswordFailure(failure.errMessage));
    }, (change) async {
      await CacheNetwork.insertToCache(key: 'password', value: newPassword);
      currentPassword = await CacheNetwork.getCacheData(key: "password");
      emit(ChangePasswordSuccess(change));
    });
  }

  Future<void> updateUserData({
    required String name,
    required String phone,
    required String email,
  }) async {
    emit(AnyThingLoading());

    var result = await uuserRepoo.updateUserData(
      name: name,
      phone: phone,
      email: email,
    );

    result.fold((failure) {
      emit(UpdateUserFailure(failure.errMessage));
    }, (update) async {
      await getProfile();
      emit(UpdateUserSuccess(update));
    });
  }
}
