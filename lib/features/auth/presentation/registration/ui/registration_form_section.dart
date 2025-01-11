import 'package:flutter/material.dart';

import '../../../../../../../core/constants/app_spaces.dart';
import '../../../../../../../core/helpers/validation_helper.dart';
import '../../../../../../../core/utils/inputs/custom_input.dart';

class RegistrationFormSection extends StatelessWidget {
  final TextEditingController username;
  final TextEditingController email;
  final TextEditingController cpassword;
  final TextEditingController password;
  const RegistrationFormSection({
    super.key,
    required this.email,
    required this.password,
    required this.cpassword,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInput(
          label: 'Enter username',
          isPassword: false,
          controller: username,
          textInputType: TextInputType.name,
          validator: (value) =>
              ValidationHelper.checkEmptyField(value, field: 'username'),
        ),
        AppSpaces.medium,
        CustomInput(
          label: 'Enter email address',
          isPassword: false,
          controller: email,
          textInputType: TextInputType.emailAddress,
          validator: (value) =>
              ValidationHelper.checkEmptyField(value, field: 'email'),
        ),
        AppSpaces.medium,
        CustomInput(
          label: 'Enter Password',
          isPassword: true,
          controller: password,
          textInputType: TextInputType.visiblePassword,
          validator: (value) =>
              ValidationHelper.checkEmptyField(value, field: 'Password'),
        ),
        AppSpaces.medium,
        CustomInput(
          label: 'Confirm Password',
          isPassword: true,
          controller: cpassword,
          textInputType: TextInputType.visiblePassword,
          validator: (value) =>
              ValidationHelper.checkEmptyField(value, field: 'cPassword'),
        ),
      ],
    );
  }

  // String? _emailError(LoginState state) => state.whenOrNull(
  //       failure: (error, emailError) => emailError,
  //     );
}
