import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicapp/providers/level_provider.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;
  final LevelProvider _levelProvider;

  AuthBloc(this._firebaseAuth, this._levelProvider) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequestedandonaddUserDetails);
    on<ToggleAuthPage>(_onToggleAuthPage);
  }

  // handles sign_in actions
  void _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      String userId = _firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      await _levelProvider.loadLevelModulesCount();
      int beginnerModuleCount = _levelProvider.getModuleCount('beginner');
      int intermediateModuleCount =
          _levelProvider.getModuleCount('intermediate');
      int expertModuleCount = _levelProvider.getModuleCount('expert');

      // Update user document if necessary
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        Map<String, dynamic> levels =
            userData['levels'] as Map<String, dynamic>;

        bool needsUpdate = false;

        // Check and update 'beginner' level
        if (levels['beginner']['module_length'] != beginnerModuleCount) {
          levels['beginner']['module_length'] = beginnerModuleCount;
          needsUpdate = true;
        }

        // Check and update 'intermediate' level
        if (levels['intermediate']['module_length'] !=
            intermediateModuleCount) {
          levels['intermediate']['module_length'] = intermediateModuleCount;
          needsUpdate = true;
        }

        // Check and update 'expert' level
        if (levels['expert']['module_length'] != expertModuleCount) {
          levels['expert']['module_length'] = expertModuleCount;
          needsUpdate = true;
        }

        if (needsUpdate) {
          // Update the user document in Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({
            'levels': levels,
          });
        }
      }
      emit(const AuthSignInSuccess(isSignUp: false));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'An unknown error occurred'));
    }
  }

  // handles sign_up actions
  void _onSignUpRequestedandonaddUserDetails(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      //create user
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // add user details and number of levels to firestore

      String userId = _firebaseAuth.currentUser!.uid;
      await _levelProvider.loadLevelModulesCount();
      int beginnerModuleCount = _levelProvider.getModuleCount('beginner');
      int intermediateModuleCount =
          _levelProvider.getModuleCount('intermediate');
      int expertModuleCount = _levelProvider.getModuleCount('expert');

      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {
          'firet name': event.firstname,
          'age': event.age,
          'email': event.email,
          'levels': {
            'beginner': {
              'locked': false,
              'open': false,
              'module_length': beginnerModuleCount,
              'module_done': 0,
            },
            'intermediate': {
              'locked': true,
              'open': false,
              'module_length': intermediateModuleCount,
              'module_done': 0,
            },
            'expert': {
              'locked': true,
              'open': false,
              'module_length': expertModuleCount,
              'module_done': 0,
            },
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
