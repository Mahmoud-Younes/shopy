import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/widgets/custom_loading_indicator.dart';
import '../../../../../core/utils/widgets/error_text.dart';
import '../../manager/layout_cubit.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FavoritesSuccess) {
          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12.5),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 7.5, horizontal: 12),
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.favorites.data?.total ?? 0,
                      itemBuilder: (context, index) {
                        log(cubit.favorites.length.toString());
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color(0xFF7AC379),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 12.5),
                          child: Row(
                            children: [
                              Image.network(
                                cubit.favorites[index].data!.data![index]
                                    .product!.image!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      cubit.favorites[index].data!.data![index]
                                          .product!.name!,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff2d4569),
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            "${cubit.favorites[index].data!.data![index].product!.price!} \$"),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${cubit.favorites[index].data!.data![index].product!.oldPrice!} \$",
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        // add | remove
                                        cubit.postfavorites(
                                            productID: cubit.favorites[index]
                                                .data!.data![index].product!.id
                                                .toString());
                                      },
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      color: const Color(0xff2d4569),
                                      child: const Text("Remove"),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ));
        } else if (state is FavoritesFailure) {
          return ErrorText(error: state.error);
        } else {
          return const CustomLoadingIndicator();
        }
      },
    );
  }
}
