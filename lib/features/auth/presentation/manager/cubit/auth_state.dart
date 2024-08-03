part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginFailure extends AuthState {
  final String errMessage;
  LoginFailure(this.errMessage);
}

class LoginSuccess extends AuthState {
  final UserModel userModel;
  LoginSuccess(this.userModel);
}

class RegisterLoading extends AuthState {}

class RegisterFailure extends AuthState {
  final String errMessage;

  RegisterFailure(this.errMessage);
}

class RegisterSuccess extends AuthState {
  final UserModel userModel;

  RegisterSuccess(this.userModel);
}

class Passwordvisibility extends AuthState {}
