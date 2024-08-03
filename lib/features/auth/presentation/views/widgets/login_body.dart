import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:go_router/go_router.dart';
import 'package:shopy/core/utils/function/styles.dart';

import '../../../../../core/utils/function/app_router.dart';
import '../../manager/cubit/auth_cubit.dart';
import 'custom_button.dart';
import 'custom_from_feild.dart';

class LoginBody extends StatelessWidget {
  LoginBody({super.key});
  final GlobalKey<FormState> formKey = GlobalKey();
  final email = TextEditingController();
  final password = TextEditingController();
  static bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          if (state.userModel.status!) {
            log(state.userModel.message.toString());
            log(state.userModel.data!.token.toString());
            Fluttertoast.showToast(
              msg: state.userModel.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else {
            log(state.userModel.message.toString());
            Fluttertoast.showToast(
              msg: state.userModel.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        } else if (state is LoginLoading) {
          isloading = true;
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 80),
                child: Column(
                  children: [
                    const Text('Login', style: Styles.textStyle30),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Login to your account',
                      style: Styles.textStyle20,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomFormTextField(
                      onChanged: (data) {
                        email.text = data;
                      },
                      hintText: 'email',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomFormTextField(
                      obscureText: AuthCubit.get(context).passwordVisibility,
                      suffix: SizedBox(
                        height: 18,
                        width: 24,
                        child: IconButton(
                          padding: const EdgeInsets.only(
                            right: 40,
                          ),
                          onPressed: AuthCubit.get(context).passwordShow,
                          icon: Icon(
                            AuthCubit.get(context).suffix,
                          ),
                        ),
                      ),
                      onChanged: (data) {
                        password.text = data;
                      },
                      hintText: 'Password',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    isloading == false
                        ? CustomButon(
                            text: 'Login',
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<AuthCubit>(context).login(
                                  email: email.text,
                                  password: password.text,
                                );
                              }
                              GoRouter.of(context)
                                  .pushReplacement(AppRouter.kLayoutView);
                            },
                          )
                        : const CircularProgressIndicator(),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: Styles.textStyle14,
                        ),
                        TextButton(
                            onPressed: () {
                              GoRouter.of(context)
                                  .pushReplacement(AppRouter.kRegisterView);
                            },
                            child: const Text(
                              'Register',
                              style: Styles.textStyle16,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
