import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthBloc(this._firebaseAuth) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequestedandonaddUserDetails);
    on<ToggleAuthPage>(_onToggleAuthPage);
  }

  void _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(const AuthSignInSuccess(isSignUp: false));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'An unknown error occurred'));
    }
  }

  void _onSignUpRequestedandonaddUserDetails(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      //create user
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // add user details to firestore
      String userId = _firebaseAuth.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {
          'firet name': event.firstname,
          'age': event.age,
          'email': event.email,
          'levels': {
            'beginner': {'locked':false,'open': false, 'module_length':4,'module_done':0},
            'intermediate': {'locked':true,'open': false ,'module_length':1,'module_done':0},
            'expert': {'locked':true,'open': false, 'module_length':1,'module_done':0},
          },
        },
      );
      emit(
        const AuthSignInSuccess(isSignUp: true),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        AuthError(e.message ?? 'An unknown error occurred'),
      );
    }
  }

  void _onToggleAuthPage(ToggleAuthPage event, Emitter<AuthState> emit) {
    if (state is AuthPageState) {
      final currentState = state as AuthPageState;
      emit(
        AuthPageState(
          showLoginPage: !currentState.showLoginPage,
        ),
      );
    } else {
      emit(
        const AuthPageState(
          showLoginPage: true,
        ),
      );
    }
  }
}
