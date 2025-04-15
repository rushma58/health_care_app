import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/utils/toasts/custom_toasts.dart';

import '../../../../../../config/routes/app_router.dart';
import '../../../../../../core/utils/buttons/expanded_filled_button.dart';
import '../../../../service/auth/auth_bloc.dart';
import '../../../../service/auth/auth_event.dart';
import '../../../../service/auth_service.dart';

class LoginButtonSection extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  const LoginButtonSection({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LoginButton(
          email: email,
          password: password,
        ),
      ],
    );
  }
}

class _LoginButton extends StatefulWidget {
  final TextEditingController email;
  final TextEditingController password;
  const _LoginButton({
    required this.email,
    required this.password,
  });

  @override
  State<_LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<_LoginButton> {
  final AuthService authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  Future<void> _login() async {
    if (widget.email.text.isEmpty || widget.password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: widget.email.text,
        password: widget.password.text,
      );

      if (userCredential.user != null) {
        if (widget.email.text == 'admin@test.com') {
          if (mounted) {
            AutoRouter.of(context).pushAndPopUntil(
              const AdminDashboardRoute(),
              predicate: (route) => false,
            );
          }
        } else {
          if (mounted) {
            AutoRouter.of(context).pushAndPopUntil(
              const DashboardRoute(),
              predicate: (route) => false,
            );
          }
        }

        final User user = userCredential.user!;
        final String email = user.email!;

        // Reference to Firestore
        final FirebaseFirestore db = FirebaseFirestore.instance;
        final CollectionReference users = db.collection('users');

        // Check if the user document exists
        final DocumentSnapshot userDoc = await users.doc(user.uid).get();

        // If user doesn't exist, create a new document
        if (userDoc.exists) {
          await users.doc(user.uid).update({
            'lastLogin': FieldValue.serverTimestamp(),
          });
          log('User already exists in database: $email');
        } else {
          CustomToasts.failure("Invalid Credentials");
        }

        // Get the user data from Firestore including displayName
        final userData = userDoc.data() as Map<String, dynamic>;

        // Pass both Firebase Auth user and Firestore user data to the bloc
        context.read<AuthBloc>().add(AuthUserChanged(
              user,
              userData:
                  userData, // Add this parameter to your AuthUserChanged event
            ));
      }
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';
      if (e.code == 'user-not-found') {
        message = 'No user found with this email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided';
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpandedFilledButton(
        isLoading: _isLoading,
        backgroundColor: AppColors.primary,
        title: 'Login',
        onTap: () async {
          await _login();
        });
  }
}
