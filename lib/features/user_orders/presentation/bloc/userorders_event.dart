part of 'userorders_bloc.dart';

sealed class UserordersEvent extends Equatable {
  const UserordersEvent();

  @override
  List<Object> get props => [];
}

class CompletedUserOrdersFetchingEvent extends UserordersEvent {}

class PendingUserOrdersFetchingEvent extends UserordersEvent {}
