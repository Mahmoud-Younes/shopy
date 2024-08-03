import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/widgets/custom_loading_indicator.dart';
import '../../../../../core/utils/widgets/error_text.dart';
import '../../manager/layout_cubit.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
        body: BlocConsumer<LayoutCubit, LayoutStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is CartSuccess) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10),
                  child: Column(
                    children: [
                      Expanded(
                          child: state.cart.data?.cartItems?.isNotEmpty ?? true
                              ? ListView.separated(
                                  itemCount:
                                      state.cart.data?.cartItems?.length ?? 0,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 12,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Color(0xFF7AC379)),
                                      child: Row(
                                        children: [
                                          Image.network(
                                            state.cart.data?.cartItems?[index]
                                                    .product?.image ??
                                                '',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.fill,
                                          ),
                                          const SizedBox(width: 12.5),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  state
                                                      .cart
                                                      .data!
                                                      .cartItems![index]
                                                      .product!
                                                      .name!,
                                                  style: const TextStyle(
                                                      color: Color(0xff2d4569),
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                        "${state.cart.data!.cartItems![index].product!.price!} \$"),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    if (state
                                                            .cart
                                                            .data!
                                                            .cartItems![index]
                                                            .product!
                                                            .price !=
                                                        state
                                                            .cart
                                                            .data!
                                                            .cartItems![index]
                                                            .product!
                                                            .oldPrice)
                                                      Text(
                                                        "${state.cart.data!.cartItems![index].product!.oldPrice!} \$",
                                                        style: const TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough),
                                                      ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    OutlinedButton(
                                                      onPressed: () {
                                                        cubit.postfavorites(
                                                            productID: state
                                                                .cart
                                                                .data!
                                                                .cartItems![
                                                                    index]
                                                                .product!
                                                                .id
                                                                .toString());
                                                      },
                                                      child: const Icon(
                                                        Icons.favorite_outline,
                                                      ),
                                                      // child: Icon(
                                                      //   Icons.favorite,
                                                      //   color: cubit
                                                      //           .favoritesID
                                                      //           .contains(state
                                                      //               .cart
                                                      //               .data!
                                                      //               .cartItems![
                                                      //                   index]
                                                      //               .product!
                                                      //               .id
                                                      //               .toString())
                                                      //       ? Colors.red
                                                      //       : Colors.grey,
                                                      // ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  })
                              : const Center(
                                  child: Text("Loading....."),
                                )),
                      Text(
                        "TotalPrice : ${state.cart.data?.total ?? 0} \$",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xff2d4569)),
                      )
                    ],
                  ),
                );
              } else if (state is CartFailure) {
                return ErrorText(error: state.error);
              } else {
                return const CustomLoadingIndicator();
              }
            }));
  }
}
