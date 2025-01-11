import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/utils/buttons/expanded_filled_button.dart';

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

class _LoginButton extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  const _LoginButton({
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandedFilledButton(
      isLoading: false,
      backgroundColor: AppColors.primary,
      title: 'Login',
      onTap: () {
        AutoRouter.of(context).pushNamed(AppRoutes.dashboard);
      },
    );
  }
}
