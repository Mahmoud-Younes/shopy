import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy/core/utils/function/service_locator.dart';
import 'package:shopy/features/search/presentation/manager/cubit/search_cubit.dart';
import 'package:shopy/features/search/presentation/view/widget/search_body.dart';

import '../../data/repo/search_repo_impl.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(getIT<SearchRepoImpl>()),
      child: const Scaffold(
        body: SearchBody(),
      ),
    );
  }
}
