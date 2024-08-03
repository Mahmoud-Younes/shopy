import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/widgets/custom_loading_indicator.dart';
import '../../../../../core/utils/widgets/error_text.dart';
import '../../manager/layout_cubit.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CategorySuccess) {
          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: GridView.builder(
                itemCount: 5,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 15),
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            state.category.data!.data![index].image!,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(state.category.data!.data![index].name!)
                      ],
                    ),
                  );
                }),
          ));
        } else if (state is CategoryFailure) {
          return ErrorText(error: state.error);
        } else {
          return const CustomLoadingIndicator();
        }
      },
    );
  }
}
