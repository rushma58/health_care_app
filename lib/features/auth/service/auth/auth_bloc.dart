import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<AuthUserChanged>((event, emit) async {
      // Update the state with the new user
      emit(AuthState(user: event.user, userData: event.userData));

      // Store the user's UID in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      if (event.user != null) {
        await prefs.setString('user', event.user!.uid);
      } else {
        await prefs.remove('user');
      }
    });

    on<LoadUserFromPrefs>((event, emit) async {
      // Load the user's UID from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final userUid = prefs.getString('user');

      if (userUid != null) {
        // Fetch the user from Firebase (if needed)
        final user = FirebaseAuth.instance.currentUser;

        if (user != null && user.uid == userUid) {
          final userData = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get()
              .then((t) => t.data());
          emit(AuthState(user: user, userData: userData));
        } else {
          // If the user is not logged in, clear the state
          emit(AuthState());
        }
      } else {
        // No user in SharedPreferences
        emit(AuthState());
      }
    });
  }
}
