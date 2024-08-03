import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/widgets/custom_loading_indicator.dart';
import '../../../../../../core/utils/widgets/error_text.dart';
import '../../../manager/layout_cubit.dart';

class UpdateUserDataView extends StatelessWidget {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  UpdateUserDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        if (state is ProfileSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Update Data"),
              backgroundColor: const Color(0xFF01579B),
              elevation: 0,
              foregroundColor: Colors.black,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "User Name"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Phone"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Email"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<LayoutCubit, LayoutStates>(
                    listener: (context, state) {
                      if (state is UpdateUserSuccess) {
                        showSnackBarItem(
                            context, "Data Updated Successfully", true);
                        Navigator.pop(context);
                      }
                      if (state is UpdateUserFailure) {
                        showSnackBarItem(context, state.error, false);
                      }
                    },
                    builder: (context, state) {
                      return MaterialButton(
                        onPressed: () {
                          if (nameController.text.isNotEmpty &&
                              phoneController.text.isNotEmpty &&
                              emailController.text.isNotEmpty) {
                            BlocProvider.of<LayoutCubit>(context)
                                .updateUserData(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text);
                          } else {
                            showSnackBarItem(
                                context, 'Please, Enter all Data !!', false);
                          }
                        },
                        color: const Color(0xff2d4569),
                        textColor: Colors.white,
                        child: Text(
                            state is AnyThingLoading ? "Loading..." : "Update"),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        } else if (state is ProfileFailure) {
          return ErrorText(error: state.error);
        } else {
          return const CustomLoadingIndicator();
        }
      },
    );
  }

  void showSnackBarItem(
      BuildContext context, String message, bool forSuccessOrFailure) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: forSuccessOrFailure ? Colors.green : Colors.red,
    ));
  }
}
