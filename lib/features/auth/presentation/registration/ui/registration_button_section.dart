import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/core/constants/app_colors.dart';

import '../../../../../../core/utils/buttons/expanded_filled_button.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/toasts/custom_toasts.dart';
import '../../../service/auth/auth_bloc.dart';
import '../../../service/auth/auth_event.dart';
import '../../../service/auth_service.dart';

class RegistrationButtonSection extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController userName;
  const RegistrationButtonSection({
    super.key,
    required this.email,
    required this.password,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RegistrationButton(
          email: email,
          password: password,
          userName: userName,
        ),
      ],
    );
  }
}

// class _ForgotPasswordComponent extends StatelessWidget {
//   const _ForgotPasswordComponent();

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: TappableText(
//         text: 'Forgot Password?',
//         style: TextStyles.regular14.copyWith(
//           color: AppColors.label,
//         ),
//         onTap: () => AutoRouter.of(context).pushNamed(AppRoutes.forgotPassword),
//       ),
//     );
//   }
// }

class _RegistrationButton extends StatefulWidget {
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController userName;
  const _RegistrationButton({
    required this.email,
    required this.password,
    required this.userName,
  });

  @override
  State<_RegistrationButton> createState() => _RegistrationButtonState();
}

class _RegistrationButtonState extends State<_RegistrationButton> {
  final AuthService authService = AuthService();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ExpandedFilledButton(
      isLoading: isLoading,
      backgroundColor: AppColors.primary,
      title: 'Register',
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        final result = await authService.registerWithEmailAndPassword(
            email: widget.email.text, password: widget.password.text);

        if (result == null) {
          CustomToasts.failure("Couldn't Sign In");
        }

        // if (result?.user?.email != null) {
        //   // ignore: use_build_context_synchronously
        //   AutoRouter.of(context).pushNamed(AppRoutes.dashboard);
        // }

        if (result?.user != null) {
          final User user = result!.user!;
          final String email = user.email!;

          // Reference to Firestore
          final FirebaseFirestore db = FirebaseFirestore.instance;
          final CollectionReference users = db.collection('users');

          // Check if the user document exists
          final DocumentSnapshot userDoc = await users.doc(user.uid).get();

          // If user doesn't exist, create a new document
          if (!userDoc.exists) {
            // Create user document with the user's UID as the document ID
            await users.doc(user.uid).set({
              'email': email,
              'displayName': widget.userName.text,
              'photoURL': user.photoURL,
              'createdAt': FieldValue.serverTimestamp(),
              'lastLogin': FieldValue.serverTimestamp(),
            });
            log('User added to database: $email');
          } else {
            CustomToasts.failure("Use another email, it is already used");
            // await users.doc(user.uid).update({
            //   'lastLogin': FieldValue.serverTimestamp(),
            // });
            // log('User already exists in database: $email');
          }

          context.read<AuthBloc>().add(AuthUserChanged(user));
          AutoRouter.of(context).pushNamed(AppRoutes.dashboard);
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }
}

class AgreeButton extends StatefulWidget {
  const AgreeButton({super.key});

  @override
  State<AgreeButton> createState() => _AgreeButtonState();
}

class _AgreeButtonState extends State<AgreeButton> {
  @override
  Widget build(BuildContext context) {
    // return Row(
    //   children: [Checkbox(value: "value", onChanged: () {})],
    // );
    return const SizedBox.expand();
  }
}
