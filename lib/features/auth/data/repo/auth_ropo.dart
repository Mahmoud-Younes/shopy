import 'package:dartz/dartz.dart';
import 'package:shopy/features/auth/data/model/user_model.dart';

import '../../../../core/errors/failures.dart';

abstract class AuthRopo {
  Future<Either<Failure, UserModel>> loginUser({
    required email,
    required password,
  });
  Future<Either<Failure, UserModel>> registerUser({
    required email,
    required password,
    required name,
    required phone,
  });
}
