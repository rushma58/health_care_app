import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_spaces.dart';
import 'package:health_care_app/core/constants/text_styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/infrastructure/resources/assets.dart';

class StackComponent extends StatelessWidget {
  final String text;
  const StackComponent({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            const Divider(),
            Center(
              child: Container(
                color: AppColors.white,
                padding: const EdgeInsets.all(AppConstants.gesturePadding),
                child: Text(
                  text,
                  style: TextStyles.regular10.copyWith(color: AppColors.grey),
                ),
              ),
            ),
          ],
        ),
        AppSpaces.large,
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(AppConstants.gesturePadding),
          child: const Icon(Icons.g_mobiledata),
          // child: Image.asset(Assets.googleLogo),
        ),
      ],
    );
  }
}
