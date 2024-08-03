import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../model/cart.dart';

abstract class CartRepo {
  Future<Either<Failure, CartModel>> getcart();
}
