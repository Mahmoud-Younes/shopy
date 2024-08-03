import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopy/core/utils/function/app_router.dart';

import '../../../../../core/utils/widgets/custom_loading_indicator.dart';
import '../../../../../core/utils/widgets/error_text.dart';
import '../../manager/layout_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ProfileSuccess) {
          return Scaffold(
              body: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            width: double.infinity,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(state.profile.data?.image ?? ''),
                  radius: 45,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(state.profile.data?.name ?? ''),
                const SizedBox(
                  height: 10,
                ),
                Text(state.profile.data?.email ?? ''),
                const SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kChangepassword);
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: const Text("Change Password"),
                ),
                const SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kUpdateUser);
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: const Text("Update Data"),
                )
              ],
            ),
          ));
        } else if (state is ProfileFailure) {
          return ErrorText(error: state.error);
        } else {
          return const CustomLoadingIndicator();
        }
      },
    );
  }
}
