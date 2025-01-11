import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_spaces.dart';
import 'package:health_care_app/core/constants/text_styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class UserAvatar extends StatelessWidget {
  final String name;
  final String position;
  const UserAvatar({
    super.key,
    required this.name,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AppSpaces.medium,
          const CircleAvatar(
            radius: AppConstants.mediumAvatarSize,
            backgroundColor: AppColors.lightGrey,
            child: Iconify(
              MaterialSymbols.person,
              size: AppConstants.authIconSize,
              color: AppColors.grey,
            ),
          ),
          AppSpaces.medium,
          Text(
            name,
            style: TextStyles.bold16.copyWith(
              color: AppColors.black,
            ),
          ),
          // AppSpaces.small,
          Text(
            position,
            style: TextStyles.regular16.copyWith(
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
