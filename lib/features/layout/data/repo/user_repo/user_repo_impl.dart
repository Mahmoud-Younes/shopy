import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopy/features/auth/data/model/user_model.dart';

import 'package:shopy/features/layout/data/repo/user_repo/user_repo.dart';
import '../../../../../constants.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/function/api_service.dart';

class UserRepoImpl extends UserRepo {
  final ApiService apiService;
  UserRepoImpl(this.apiService);
  @override
  Future<Either<Failure, UserModel>> getProfile() async {
    try {
      var data = await apiService.getData(
        endPoint: 'profile',
        token: userToken,
      );

      return right(UserModel.fromJson(data));
    } catch (e) {
      log(e.toString());
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> changePassword({
    required String userCurrentPassword,
    required String newPassword,
  }) async {
    try {
      var data = await apiService.post(
        endPoint: 'change-password',
        token: userToken,
        data: {
          'current_password': userCurrentPassword,
          'new_password': newPassword,
        },
      );
      return right(UserModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateUserData({
    required String name,
    required String phone,
    required String email,
  }) async {
    try {
      var data = await apiService.put(
        endPoint: 'update-profile',
        token: userToken,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        },
      );
      return right(UserModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
