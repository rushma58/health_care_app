import 'package:flutter/material.dart';
import 'package:health_care_app/features/auth/component/stack_component.dart';
import 'package:health_care_app/features/auth/presentation/registration/ui/registration_form_section.dart';
import 'package:health_care_app/features/auth/presentation/registration/ui/registration_text.dart';

import '../../../../../../core/constants/app_constants.dart';
import '../../../../../../core/constants/app_spaces.dart';
import '../../../../core/utils/inputs/custom_checkbox.dart';
import '../../component/background.dart';
import 'ui/registration_button_section.dart';

class RegistrationBody extends StatefulWidget {
  const RegistrationBody({super.key});

  @override
  State<RegistrationBody> createState() => _RegistrationBodyState();
}

class _RegistrationBodyState extends State<RegistrationBody> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _cpassword = TextEditingController();
  final _username = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _cpassword.dispose();
    _username.dispose();
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
                const RegistrationText(),
                AppSpaces.veryLarge,
                AppSpaces.veryLarge,
                RegistrationFormSection(
                  email: _email,
                  password: _password,
                  cpassword: _cpassword,
                  username: _username,
                ),
                AppSpaces.medium,
                CustomCheckbox(
                  text: 'I agree with the terms and conditions',
                  initialValue: false,
                  onChanged: (value) {
                    // Handle checkbox state change
                    print('Checkbox is now: $value');
                  },
                ),
                AppSpaces.medium,
                RegistrationButtonSection(
                  email: _email,
                  password: _password,
                ),
                AppSpaces.veryLarge,
                const StackComponent(text: "Or Sign up with"),
                AppSpaces.large,
                const NotLoginYet(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
