import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/core/errors/firebase_exceptions.dart';
import 'package:finalproject/features/auth/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuthException firebaseAuthException =
      FirebaseAuthException(code: 'user-not-found');

  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<CheckLoginStatusEvent>(_onCheckLoginStatus);
    on<SignUpEvent>(_onSignUp);
    on<LogOutEvent>(_onLogOut);
    on<LoginEvent>(_onLogin);
    on<GoogleSignInEvent>(_onGoogleSignIn);
    on<ForgetPasswordEvent>(_resetPassword);
  }

//reset password handler

  Future<void> _resetPassword(
      ForgetPasswordEvent event, Emitter<AuthBlocState> emit) async {
    String email = event.email;

    try {
      await _auth.sendPasswordResetEmail(email: email);
      emit(EmailVerifiedState(email: email));
    } on FirebaseAuthException catch (e) {
      List<String> errorMessage =
          FirebaseErrorHandler.handleFirebaseAuthError(e);
      emit(VerificationErrorState(msg: errorMessage));
    }
  }

//common handler for authentication

  Future<void> _handleAuthentication(
      User? user, UserModel userModel, Emitter<AuthBlocState> emit) async {
    if (user != null) {
      await _saveUserToFirestore(user, userModel);
      emit(AuthenticatedState(user: user));
    } else {
      emit(UnAuthenticatedState());
    }
  }

//google sign in handler

  Future<void> _onGoogleSignIn(
      GoogleSignInEvent event, Emitter<AuthBlocState> emit) async {
    emit(LoadingState());

    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(UnAuthenticatedState());
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      await _handleAuthentication(
        user,
        UserModel(
          imagepath: user?.photoURL,
          name: user?.displayName,
          email: user?.email,
          phone: user?.phoneNumber,
        ),
        emit,
      );
    } on FirebaseAuthException catch (e) {
      List<String> errorMessage =
          FirebaseErrorHandler.handleFirebaseAuthError(e);

      emit(AuthenticatonErrorState(msg: errorMessage));
    }
  }

  // Login checking handler

  Future<void> _onCheckLoginStatus(
      CheckLoginStatusEvent event, Emitter<AuthBlocState> emit) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      User? user = _auth.currentUser;

      if (user != null) {
        emit(AuthenticatedState(user: user));
      } else {
        emit(UnAuthenticatedState());
      }
    } on FirebaseAuthException catch (e) {
      List<String> errorMessage =
          FirebaseErrorHandler.handleFirebaseAuthError(e);

      emit(AuthenticatonErrorState(msg: errorMessage));
    }
  }

//sign in event

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthBlocState> emit) async {
    emit(LoadingState());

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: event.userModel.email!,
        password: event.userModel.password!,
      );

      final user = userCredential.user;

      await _handleAuthentication(user, event.userModel, emit);
    } catch (e) {
      emit(SignInErrorState(msg: e.toString()));
    }
  }

  // handler for save datas into firebase

  Future<void> _saveUserToFirestore(User user, UserModel userModel) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'name': userModel.name,
      'phone': userModel.phone,
      'createdAT': DateTime.now(),
      'imagepath': userModel.imagepath,
      'cart2': {},
      'favorites': []
    });
  }

  //log out evnet handler

  Future<void> _onLogOut(LogOutEvent event, Emitter<AuthBlocState> emit) async {
    try {
      await _auth.signOut();
      emit(UnAuthenticatedState());
    } on FirebaseAuthException catch (e) {
      List<String> errorMessage =
          FirebaseErrorHandler.handleFirebaseAuthError(e);

      emit(AuthenticatonErrorState(msg: errorMessage));
    }
  }

  //login event handler

  Future<void> _onLogin(LoginEvent event, Emitter<AuthBlocState> emit) async {
    emit(LoadingState());

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      final user = userCredential.user;

      if (user != null) {
        emit(AuthenticatedState(user: user));
      } else {
        emit(UnAuthenticatedState());
      }
    } on FirebaseAuthException catch (e) {
      List<String> errorMessage =
          FirebaseErrorHandler.handleFirebaseAuthError(e);

      emit(AuthenticatonErrorState(msg: errorMessage));
    }
  }
}
