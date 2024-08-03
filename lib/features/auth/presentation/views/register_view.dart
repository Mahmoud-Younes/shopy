import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy/core/utils/function/service_locator.dart';
import 'package:shopy/features/auth/data/repo/auth_repo_impl.dart';
import 'package:shopy/features/auth/presentation/manager/cubit/auth_cubit.dart';

import 'widgets/register_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIT<AuthRepoImpl>()),
      child: RegisterBody(),
    );
  }
}
