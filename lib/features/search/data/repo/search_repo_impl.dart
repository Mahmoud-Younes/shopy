import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopy/constants.dart';
import 'package:shopy/features/search/data/model/search.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/function/api_service.dart';
import 'search_repo.dart';

class SearchRepoImpl extends SearchRepo {
  final ApiService apiService;
  SearchRepoImpl(this.apiService);

  @override
  Future<Either<Failure, SearchModel>> search({
    required String query,
  }) async {
    try {
      var data = await apiService.post(
        endPoint: 'products/search',
        token: userToken,
        data: {
          "text": query,
        },
      );
      return right(SearchModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
