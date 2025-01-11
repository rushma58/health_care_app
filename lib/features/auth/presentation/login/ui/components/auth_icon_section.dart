import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_constants.dart';

class AuthIconSection extends StatelessWidget {
  final IconData icon;
  final IconData smallIcon;
  const AuthIconSection({
    super.key,
    required this.icon,
    required this.smallIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.screenPadding * 2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.veryLightBlue,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            icon,
            size: AppConstants.authIconSize,
            color: AppColors.primary,
          ),
          Positioned(
            bottom: -10,
            right: -10,
            child: Container(
              padding: const EdgeInsets.all(AppConstants.screenPadding * .5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.veryLightBlue,
              ),
              child: Icon(
                smallIcon,
                size: AppConstants.smallIconSize,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
