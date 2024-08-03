import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/utils/function/app_router.dart';
import '../../../../core/utils/function/assets.dart';
import '../../../../core/utils/function/styles.dart';
import '../../data/model.dart';
import 'widget/on_board_item.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  var boardController = PageController();
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
      image: AssetsData.ima1,
      title: 'shop',
      body: 'gggggggggg',
    ),
    BoardingModel(
      image: AssetsData.ima1,
      title: ' shop',
      body: 'gggggggggg',
    ),
    BoardingModel(
      image: AssetsData.ima2,
      title: ' shop',
      body: 'gggggggggg',
    ),
    BoardingModel(
      image: AssetsData.ima2,
      title: ' shop',
      body: 'gggggggggg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFEFEFE),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFEFEFE),
          actions: [
            TextButton(
                onPressed: () {
                  GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
                },
                child: Text(
                  'Skip',
                  style: Styles.textStyle18.copyWith(color: Colors.blue),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildBordingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.blue,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      if (isLast) {
                        GoRouter.of(context)
                            .pushReplacement(AppRouter.kLoginView);
                      } else {
                        boardController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
