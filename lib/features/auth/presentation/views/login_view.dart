import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy/features/auth/presentation/manager/cubit/auth_cubit.dart';
import '../../../../core/utils/function/service_locator.dart';
import '../../data/repo/auth_repo_impl.dart';
import 'widgets/login_body.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIT<AuthRepoImpl>()),
      child: Scaffold(
        body: LoginBody(),
      ),
    );
  }
}
