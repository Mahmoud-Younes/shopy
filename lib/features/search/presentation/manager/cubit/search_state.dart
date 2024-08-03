part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final SearchModel searchModel;
  SearchSuccess(this.searchModel);
}

class SearchFailure extends SearchState {
  final String error;
  SearchFailure(this.error);
}
