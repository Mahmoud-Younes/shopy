import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../model/favorites.dart';

abstract class FavoritesRepo {
  Future<Either<Failure, FavoritesModel>> getfavorites();

  Future<Either<Failure, FavoritesModel>> postfavorites({
    required String productID,
  });
}
