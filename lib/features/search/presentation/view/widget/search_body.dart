import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/function/styles.dart';
import '../../../../../core/utils/widgets/error_text.dart';
import '../../../data/model/search.dart';
import '../../manager/cubit/search_cubit.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                controller: _searchController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  labelText: 'Search',
                  labelStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _performSearch(value);
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SearchSuccess) {
                    return _buildSearchResults(state.searchModel);
                  } else if (state is SearchFailure) {
                    return ErrorText(error: state.error);
                  } else {
                    return const Center(
                      child: Text('أنقر للبحث'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(SearchModel data) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: data.data?.data.length ?? 0,
      itemBuilder: (context, index) {
        final datum = data.data?.data[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.all(20),
            title: Text(
              datum?.name ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Styles.textStyle20,
            ),
            subtitle: Text(
                style: Styles.textStyle14,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                datum?.description ?? ''),
            leading: SizedBox(
                height: 70,
                width: 55,
                child: Image.network(datum?.image ?? '')),
          ),
        );
      },
    );
  }

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      context.read<SearchCubit>().search(query: query);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
