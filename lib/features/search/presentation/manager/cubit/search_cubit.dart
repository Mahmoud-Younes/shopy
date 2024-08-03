import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/search.dart';
import '../../../data/repo/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchrepo) : super(SearchInitial());

  SearchRepo searchrepo;
  Future<void> search({
    required String query,
  }) async {
    emit(SearchLoading());
    var result = await searchrepo.search(
      query: query,
    );
    result.fold(
      (l) {
        emit(SearchFailure(l.errMessage));
      },
      (r) {
        emit(SearchSuccess(r));
      },
    );
  }
}
