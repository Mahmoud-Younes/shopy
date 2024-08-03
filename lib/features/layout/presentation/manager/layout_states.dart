part of 'layout_cubit.dart';

abstract class LayoutStates {}

class LayoutInitialState extends LayoutStates {}

class AnyThingLoading extends LayoutStates {}

class ChangeBottomNavIndexState extends LayoutStates {}

class ProfileSuccess extends LayoutStates {
  final UserModel profile;
  ProfileSuccess(this.profile);
}

class ProfileFailure extends LayoutStates {
  final String error;
  ProfileFailure(this.error);
}

class HomeSuccess extends LayoutStates {
  final HomeModel home;
  HomeSuccess(this.home);
}

class HomeFailure extends LayoutStates {
  final String error;
  HomeFailure(this.error);
}

class CategorySuccess extends LayoutStates {
  final CategoryModel category;
  CategorySuccess(this.category);
}

class CategoryFailure extends LayoutStates {
  final String error;
  CategoryFailure(this.error);
}

class FavoritesSuccess extends LayoutStates {
  final FavoritesModel favorites;
  FavoritesSuccess(this.favorites);
}

class FavoritesFailure extends LayoutStates {
  final String error;
  FavoritesFailure(this.error);
}

class PostFavoritesSuccess extends LayoutStates {
  final FavoritesModel postfavorites;
  PostFavoritesSuccess(this.postfavorites);
}

class PostFavoritesFailure extends LayoutStates {
  final String error;
  PostFavoritesFailure(this.error);
}

class FilterProductsSuccess extends LayoutStates {}

class CartSuccess extends LayoutStates {
  final CartModel cart;
  CartSuccess(this.cart);
}

class CartFailure extends LayoutStates {
  final String error;
  CartFailure(this.error);
}

class ChangePasswordSuccess extends LayoutStates {
  final UserModel changePassword;
  ChangePasswordSuccess(this.changePassword);
}

class ChangePasswordFailure extends LayoutStates {
  final String error;
  ChangePasswordFailure(this.error);
}

class UpdateUserSuccess extends LayoutStates {
  final UserModel updateUser;
  UpdateUserSuccess(this.updateUser);
}

class UpdateUserFailure extends LayoutStates {
  final String error;
  UpdateUserFailure(this.error);
}
