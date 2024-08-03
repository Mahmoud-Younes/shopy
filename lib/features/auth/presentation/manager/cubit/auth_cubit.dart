import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../constants.dart';
import '../../../../../core/utils/function/cacheNetwork.dart';
import '../../../data/model/user_model.dart';
import '../../../data/repo/auth_ropo.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRopo) : super(AuthInitial());

  AuthRopo authRopo;
  static AuthCubit get(context) => BlocProvider.of(context);
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    var result = await authRopo.loginUser(
      email: email,
      password: password,
    );

    result.fold((failure) {
      emit(LoginFailure(failure.errMessage));
    }, (loggmodel) async {
      await CacheNetwork.insertToCache(
          key: "token", value: loggmodel.data?.token ?? ''); // not null anyway
      await CacheNetwork.insertToCache(key: "password", value: password);
      userToken = await CacheNetwork.getCacheData(key: "token");
      currentPassword = await CacheNetwork.getCacheData(key: "password");
      emit(LoginSuccess(loggmodel));
    });
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(RegisterLoading());

    var result = await authRopo.registerUser(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );

    result.fold((failure) {
      emit(RegisterFailure(failure.errMessage));
    }, (registerrmodel) async {
      await CacheNetwork.insertToCache(
          key: "token", value: registerrmodel.data?.token ?? '');
      await CacheNetwork.insertToCache(key: "password", value: password);
      userToken = await CacheNetwork.getCacheData(key: "token");
      currentPassword = await CacheNetwork.getCacheData(key: "password");
      emit(RegisterSuccess(registerrmodel));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool passwordVisibility = true;
  void passwordShow() {
    suffix = passwordVisibility
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    passwordVisibility = !passwordVisibility;
    emit(Passwordvisibility());
  }
}
