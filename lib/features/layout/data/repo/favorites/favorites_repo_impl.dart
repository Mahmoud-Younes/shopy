import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopy/constants.dart';
import 'package:shopy/features/layout/data/model/favorites.dart';
import 'package:shopy/features/layout/data/repo/favorites/favorites_repo.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/function/api_service.dart';

class FavoritesRepoImpl extends FavoritesRepo {
  final ApiService apiService;
  FavoritesRepoImpl(this.apiService);
  @override
  Future<Either<Failure, FavoritesModel>> getfavorites() async {
    try {
      var data =
          await apiService.getData(endPoint: 'favorites', token: userToken);

      return right(FavoritesModel.fromJson(data));
    } catch (e) {
      log(e.toString());
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FavoritesModel>> postfavorites({
    required String productID,
  }) async {
    try {
      var data = await apiService.post(
        endPoint: 'favorites',
        token: userToken,
        data: {
          "product_id": productID,
        },
      );
      return right(FavoritesModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
