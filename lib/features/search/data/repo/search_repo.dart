import 'package:dartz/dartz.dart';
import 'package:shopy/features/search/data/model/search.dart';

import '../../../../core/errors/failures.dart';

abstract class SearchRepo {
  Future<Either<Failure, SearchModel>> search({
    required String query,
  });
}
