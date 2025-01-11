import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';

import '../../../../../../../core/constants/app_spaces.dart';
import '../../../../../../../core/helpers/validation_helper.dart';
import '../../../../../../../core/utils/inputs/custom_input.dart';

class LoginFormSection extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  const LoginFormSection({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // BlocBuilder<LoginBloc, LoginState>(
        //   builder: (context, state) => CustomInput(
        //     label: 'Email',
        //     controller: email,
        //     textInputType: TextInputType.emailAddress,
        //     errorText: _emailError(state),
        //     validator: (value) => ValidationHelper.emailValidator(value),
        //   ),
        // ),
        CustomInput(
          label: 'Enter Email Address',
          isPassword: false,
          controller: email,
          textInputType: TextInputType.emailAddress,
          suffix: const Icon(
            Icons.mail_outline,
            color: AppColors.border,
          ),
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
      ],
    );
  }

  // String? _emailError(LoginState state) => state.whenOrNull(
  //       failure: (error, emailError) => emailError,
  //     );
}
