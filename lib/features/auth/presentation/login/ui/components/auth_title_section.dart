import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_constants.dart';
import '../../../../../../core/constants/app_spaces.dart';
import '../../../../../../core/constants/text_styles.dart';

class AuthTitleSection extends StatelessWidget {
  final String title;
  final String subtitle;
  const AuthTitleSection({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppConstants.screenPadding),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyles.extraBold16.copyWith(
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpaces.verySmall,
          Text(
            subtitle,
            style: TextStyles.regular15.copyWith(
              color: AppColors.lightText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
