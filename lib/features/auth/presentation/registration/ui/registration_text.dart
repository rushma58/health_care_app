import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_spaces.dart';
import 'package:health_care_app/core/constants/text_styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/radix_icons.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/constants/app_colors.dart';

class RegistrationText extends StatelessWidget {
  const RegistrationText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create an Account",
              style: TextStyles.bold24,
            ),
            AppSpaces.smallWidth,
            Iconify(RadixIcons.person),
          ],
        ),
      ],
    );
  }
}

class NotLoginYet extends StatelessWidget {
  const NotLoginYet({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Have an Account?",
          style: TextStyles.regular14,
        ),
        AppSpaces.mediumWidth,
        TextButton(
          onPressed: () {
            context.router.replaceNamed(AppRoutes.login);
          },
          child: Text(
            "Sign In",
            style: TextStyles.bold16.copyWith(color: AppColors.black),
          ),
        ),
      ],
    );
  }
}
