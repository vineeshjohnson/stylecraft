// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

final class LoadingState extends AuthBlocState {}

final class AuthenticatedState extends AuthBlocState {
  final User? user;
  AuthenticatedState({this.user});
}

class UnAuthenticatedState extends AuthBlocState {}

class AuthenticatonErrorState extends AuthBlocState {
  final List<String> msg;
  AuthenticatonErrorState({
    required this.msg,
  });
}

class SignInErrorState extends AuthBlocState {
  final String msg;
  SignInErrorState({
    required this.msg,
  });
}

class EmptyErrorState extends AuthBlocState {}

class EmailVerifiedState extends AuthBlocState {
  final String email;
  EmailVerifiedState({
    required this.email,
  });
}

class VerificationErrorState extends AuthBlocState {
  final List<String> msg;
  VerificationErrorState({
    required this.msg,
  });
}
