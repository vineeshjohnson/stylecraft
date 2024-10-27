import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProfileBloc() : super(ProfileInitial()) {
    on<FetchUserProfileEvent>(_onFetchUserProfile);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);
  }

  Future<void> _onFetchUserProfile(
      FetchUserProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(event.uid).get();
      if (snapshot.exists) {
        emit(ProfileLoaded(userData: snapshot.data() as Map<String, dynamic>));
      } else {
        emit(const ProfileError(message: 'User data not found'));
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onUpdateUserProfile(
      UpdateUserProfileEvent event, Emitter<ProfileState> emit) async {
    await _firestore
        .collection('users')
        .doc(event.uid)
        .update(event.updatedData);
    emit(ProfileUpdated(userData: event.updatedData));
  }
}
