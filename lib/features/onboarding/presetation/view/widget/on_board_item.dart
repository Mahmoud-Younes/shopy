import 'package:flutter/material.dart';

import '../../../../../core/utils/function/styles.dart';
import '../../../data/model.dart';

Widget buildBordingItem(BoardingModel board) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(
            board.image,
          ),
        ),
        Text(board.title,
            style: Styles.textStyle30.copyWith(color: Colors.blue)),
        const SizedBox(
          height: 50,
        ),
        Text(board.body,
            style: Styles.textStyle18.copyWith(color: Colors.blue)),
        const SizedBox(
          height: 30,
        ),
      ],
    );
