import 'package:dartz/dartz.dart';
import 'package:shopy/features/auth/data/model/user_model.dart';
import '../../../../../core/errors/failures.dart';

abstract class UserRepo {
  Future<Either<Failure, UserModel>> getProfile();
  Future<Either<Failure, UserModel>> changePassword({
    required String userCurrentPassword,
    required String newPassword,
  });
  Future<Either<Failure, UserModel>> updateUserData({
    required String name,
    required String phone,
    required String email,
  });
}
