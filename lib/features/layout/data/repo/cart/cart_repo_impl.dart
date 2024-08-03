import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopy/constants.dart';
import 'package:shopy/features/layout/data/model/cart.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/function/api_service.dart';
import 'cart_repo.dart';

class CartRepoImpl extends CartRepo {
  final ApiService apiService;
  CartRepoImpl(this.apiService);
  @override
  Future<Either<Failure, CartModel>> getcart() async {
    try {
      var data = await apiService.getData(
        endPoint: 'carts',
        token: userToken,
      );

      return right(CartModel.fromJson(data));
    } catch (e) {
      log(e.toString());
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
