import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserProfileEvent extends ProfileEvent {
  final String uid;

  const FetchUserProfileEvent({required this.uid});
}

class UpdateUserProfileEvent extends ProfileEvent {
  final String uid;
  final Map<String, dynamic> updatedData;

  const UpdateUserProfileEvent({required this.uid, required this.updatedData});
}
