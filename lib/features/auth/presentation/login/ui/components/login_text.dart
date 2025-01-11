import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_spaces.dart';
import 'package:health_care_app/core/constants/text_styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/radix_icons.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/constants/app_colors.dart';

class LoginText extends StatelessWidget {
  const LoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login Account",
              style: TextStyles.bold24,
            ),
            AppSpaces.smallWidth,
            Iconify(RadixIcons.person),
          ],
        ),
        AppSpaces.small,
        Text(
          "Welcome Guest !",
          style: TextStyles.regular14,
        ),
      ],
    );
  }
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: () {
          // context.router.replaceNamed(AppRoutes.register);
        },
        child: Text(
          "Forgot Password ?",
          style: TextStyles.regular14.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}

class NotRegisteredYet extends StatelessWidget {
  const NotRegisteredYet({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Not Registered Yet?",
          style: TextStyles.regular14,
        ),
        AppSpaces.mediumWidth,
        TextButton(
          onPressed: () {
            context.router.replaceNamed(AppRoutes.register);
          },
          child: Text(
            "Register Here",
            style: TextStyles.bold16.copyWith(color: AppColors.black),
          ),
        ),
      ],
    );
  }
}
