import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopy/constants.dart';
import 'package:shopy/features/layout/data/model/category_model.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/function/api_service.dart';
import '../../model/home.dart';
import 'home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final ApiService apiService;
  HomeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, HomeModel>> getHome() async {
    try {
      var data = await apiService.getData(
        token: userToken,
        endPoint: 'home',
      );

      return right(HomeModel.fromJson(data));
    } catch (e) {
      log(e.toString());
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> getCategory() async {
    try {
      var data = await apiService.getData(
        token: userToken,
        endPoint: 'categories',
      );
      return right(CategoryModel.fromJson(data));
    } catch (e) {
      log(e.toString());
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
