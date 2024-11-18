part of 'userprofile_bloc.dart';

sealed class UserprofileState extends Equatable {
  const UserprofileState();

  @override
  List<Object> get props => [];
}

final class UserprofileInitial extends UserprofileState {}

final class UserProfileFetchedState extends UserprofileState {
  final List<String> uerdetails;
  const UserProfileFetchedState({required this.uerdetails});
}

final class ImagePickedState extends UserprofileState {
  final File image;
  const ImagePickedState({required this.image});
}

final class DataUpdatedState extends UserprofileState {}

final class LoadingStatw extends UserprofileState {}
