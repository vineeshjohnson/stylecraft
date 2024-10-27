// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

class CheckLoginStatusEvent extends AuthBlocEvent {}

class LoginEvent extends AuthBlocEvent {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthBlocEvent {
  final UserModel userModel;
  SignUpEvent({
    required this.userModel,
  });
}

class LogOutEvent extends AuthBlocEvent {}

class GoogleSignInEvent extends AuthBlocEvent {}

class ForgetPasswordEvent extends AuthBlocEvent {
  final String email;
  ForgetPasswordEvent({
    required this.email,
  });
}
