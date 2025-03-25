import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream to listen to authentication state changes
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // Email and Password Registration
  Future<UserCredential?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      log('Registration Error: ${e.message}');
      return null;
    } catch (e) {
      log('Unexpected registration error: $e');
      return null;
    }
  }

  // Email and Password Login
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      log('Login Error: ${e.message}');
      return null;
    } catch (e) {
      log('Unexpected login error: $e');
      return null;
    }
  }

  // // Google Sign-In
  // Future<UserCredential?> signInWithGoogle() async {
  //   try {
  //     // Trigger the Google Sign-In process
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     if (googleUser == null) return null;

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     // Sign in to Firebase with the Google credential
  //     return await _auth.signInWithCredential(credential);
  //   } catch (e) {
  //     print('Google Sign-In Error: $e');
  //     return null;
  //   }
  // }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log('Sign out error: $e');
    }
  }

  // Reset Password
  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log('Password Reset Error: $e');
    }
  }
}
