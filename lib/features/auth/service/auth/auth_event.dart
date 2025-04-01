import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent {}

class AuthUserChanged extends AuthEvent {
  final User? user;
  final Map<String, dynamic>? userData;

  AuthUserChanged(this.user, {this.userData});
}

class LoadUserFromPrefs extends AuthEvent {}
