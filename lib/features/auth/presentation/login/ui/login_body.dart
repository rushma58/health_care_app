import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';

import '../../../../../../core/constants/app_constants.dart';
import '../../../../../../core/constants/app_spaces.dart';
import '../../../component/background.dart';
import '../../../component/stack_component.dart';
import 'components/login_button_section.dart';
import 'components/login_form_section.dart';
import 'components/login_text.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.screenPadding),
        child: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LoginText(),
                AppSpaces.veryLarge,
                AppSpaces.veryLarge,
                LoginFormSection(
                  email: _email,
                  password: _password,
                ),
                AppSpaces.medium,
                const ForgotPassword(),
                AppSpaces.medium,
                LoginButtonSection(
                  email: _email,
                  password: _password,
                ),
                AppSpaces.veryLarge,
                const StackComponent(
                  text: "Or Login With",
                ),
                AppSpaces.veryLarge,
                const NotRegisteredYet(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
