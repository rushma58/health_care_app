import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  final User? user;

  final Map<String, dynamic>? userData; // Includes displayName

  AuthState({this.user, this.userData});

  String? get displayName => userData?['displayName'];
}
