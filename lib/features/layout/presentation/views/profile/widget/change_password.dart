import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../constants.dart';
import '../../../../../../core/utils/function/show_snack_bar.dart';
import '../../../manager/layout_cubit.dart';

class ChangePasswordView extends StatelessWidget {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        backgroundColor: Colors.blue,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: currentPasswordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Current Password"),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: newPasswordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "New Password"),
            ),
            const SizedBox(
              height: 24,
            ),
            BlocConsumer<LayoutCubit, LayoutStates>(listener: (context, state) {
              if (state is ChangePasswordSuccess) {
                showSnackBarItem(
                    context, "Password Updated Successfully", true);
                Navigator.pop(context);
              }
              if (state is ChangePasswordFailure) {
                showSnackBarItem(context, state.error, false);
              }
            }, builder: (context, state) {
              return MaterialButton(
                onPressed: () {
                  debugPrint(
                      "From TextField : ${currentPasswordController.text} , current : $currentPassword");
                  if (currentPasswordController.text == currentPassword) {
                    if (newPasswordController.text.length >= 6) {
                      cubit.changePassword(
                          userCurrentPassword: currentPassword!,
                          newPassword: newPasswordController.text.trim());
                    } else {
                      showSnackBarItem(context,
                          "Password must be at least 6 characters", false);
                    }
                  } else {
                    showSnackBarItem(
                        context,
                        "please, verify current password, try again later",
                        false);
                  }
                },
                color: Colors.blue,
                height: 45,
                minWidth: double.infinity,
                textColor: Colors.white,
                child: Text(state is AnyThingLoading ? "Loading..." : "Update"),
              );
            })
          ],
        ),
      ),
    );
  }
}
