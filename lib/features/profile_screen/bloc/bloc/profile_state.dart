import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> userData;

  const ProfileLoaded({required this.userData});
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});
}

class ProfileUpdated extends ProfileState {
  final Map<String, dynamic> userData;
  const ProfileUpdated({required this.userData});
}
