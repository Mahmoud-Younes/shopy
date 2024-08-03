import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy/features/layout/data/model/home.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../core/utils/widgets/error_text.dart';
import '../../manager/layout_cubit.dart';

class HomeScreen extends StatelessWidget {
  final pageController = PageController();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 15),
            child: ListView(
              shrinkWrap: true,
              children: [
                // Todo: Display Banners

                Banner(pageController: pageController),
                const SizedBox(
                  height: 15,
                ),
                // Todo: Smooth Page Indicator
                Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    axisDirection: Axis.horizontal,
                    effect: const SlideEffect(
                        spacing: 8.0,
                        radius: 25,
                        dotWidth: 16,
                        dotHeight: 16.0,
                        paintStyle: PaintingStyle.stroke,
                        strokeWidth: 1.5,
                        dotColor: Colors.grey,
                        activeDotColor: Color(0xFF3788CC)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                          color: Color(0xff2d4569),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "View all",
                      style: TextStyle(
                          color: Color(0xFF3788CC),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Category(),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Products",
                      style: TextStyle(
                          color: Color(0xff2d4569),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "View all",
                      style: TextStyle(
                          color: Color(0xFF3788CC),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),

                Product()
              ],
            ),
          ));
        });
  }
}

class Product extends StatelessWidget {
  const Product({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          final data = state.home.data?.products;
          return GridView.builder(
              itemCount: data?.length ?? 0,
              //  cubit.filteredProducts.isEmpty
              //     ? cubit.products.length
              //     : cubit.filteredProducts.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.7),
              itemBuilder: (context, index) {
                //  return _productItem(state.home.data?.products?[index] ?? []
                return BlocBuilder<LayoutCubit, LayoutStates>(
                    builder: (context, state) {
                  if (state is HomeSuccess) {
                    return ProductItem(products: state.home);
                  } else {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                });
              });
        }
        if (state is HomeFailure) {
          return ErrorText(error: state.error);
        } else {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}

class Category extends StatelessWidget {
  const Category({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        if (state is CategorySuccess) {
          return SizedBox(
            height: 70,
            width: double.infinity,
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount:
                    //    state.category[index].data.data.length,
                    5,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 15,
                  );
                },
                itemBuilder: (context, index) {
                  return CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                        state.category.data?.data?[index].image ?? ''),
                  );
                }),
          );
        }
        if (state is CategoryFailure) {
          return ErrorText(error: state.error);
        } else {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is HomeSuccess) {
          return SizedBox(
            height: 150,
            width: double.infinity,
            child: PageView.builder(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Image.network(
                    state.home.data?.banners?[index].image ?? '',
                    fit: BoxFit.fill,
                  );
                }),
          );
        }
        if (state is HomeFailure) {
          return ErrorText(error: state.error);
        } else {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, this.products});
  final HomeModel? products;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey.withOpacity(0.2),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              products?.data?.products?[4].image ?? '',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            products?.data?.products?[5].name ?? '',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${products?.data?.products?[1].price ?? 0} \$",
                          style: const TextStyle(fontSize: 13),
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '',
                        // "${data.oldPrice} \$",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12.5,
                            decoration: TextDecoration.lineThrough),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                child: Icon(
                  Icons.favorite,
                  size: 20,
                  color: products?.data?.products?[8].inFavorites ?? false
                      ? Colors.red
                      : Colors.grey,
                ),
                onTap: () {
                  // Add | remove product favorites
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
// Widget _productItem(
//     data /*{required HomeModel model , required LayoutCubit cubit}*/) {
// }
