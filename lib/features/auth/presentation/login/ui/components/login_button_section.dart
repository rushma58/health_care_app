import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/utils/toasts/custom_toasts.dart';

import '../../../../../../config/routes/app_routes.dart';
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
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ExpandedFilledButton(
      isLoading: isLoading,
      backgroundColor: AppColors.primary,
      title: 'Login',
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        final result = await authService.signInWithEmailAndPassword(
            email: widget.email.text, password: widget.password.text);

        log(">>>>>>>>>>>>>>>>>>>>$result");

        if (result == null) {
          CustomToasts.failure("Couldn't Sign In");
        }

        if (result?.user != null) {
          final User user = result!.user!;
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

          context.read<AuthBloc>().add(AuthUserChanged(user));
          AutoRouter.of(context).pushNamed(AppRoutes.dashboard);
          setState(() {
            isLoading = false;
          });
        }
        setState(() {
          isLoading = false;
        });
      },
    );
  }
}
