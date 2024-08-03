import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../model/category_model.dart';
import '../../model/home.dart';

abstract class HomeRepo {
  Future<Either<Failure, HomeModel>> getHome();

  Future<Either<Failure, CategoryModel>> getCategory();
}
