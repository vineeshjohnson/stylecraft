part of 'userprofile_bloc.dart';

sealed class UserprofileEvent extends Equatable {
  const UserprofileEvent();

  @override
  List<Object> get props => [];
}

class ProfileFetchEvent extends UserprofileEvent {}

class ImagePickingEvent extends UserprofileEvent {}

class UpdateDataEvent extends UserprofileEvent {
  const UpdateDataEvent({this.image, required this.name, required this.number});
  final File? image;
  final String name;
  final String number;
}
