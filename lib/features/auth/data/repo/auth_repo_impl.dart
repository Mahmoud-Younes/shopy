import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopy/core/errors/failures.dart';
import 'package:shopy/core/utils/function/api_service.dart';
import 'package:shopy/features/auth/data/model/user_model.dart';
import 'package:shopy/features/auth/data/repo/auth_ropo.dart';

class AuthRepoImpl implements AuthRopo {
  final ApiService apiService;
  AuthRepoImpl(this.apiService);
  @override
  Future<Either<Failure, UserModel>> loginUser({
    required email,
    required password,
  }) async {
    try {
      var data = await apiService.post(
        endPoint: 'login',
        data: {
          'email': email,
          'password': password,
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
  Future<Either<Failure, UserModel>> registerUser({
    required email,
    required password,
    required name,
    required phone,
  }) async {
    try {
      var data = await apiService.post(
        endPoint: 'login',
        data: {
          'email': email,
          'password': password,
          'name': name,
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
