import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/text_styles.dart';

class CallDoctorTile extends StatelessWidget {
  final Widget image;
  final String title;
  final String profession;
  const CallDoctorTile({
    super.key,
    required this.image,
    required this.title,
    required this.profession,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          // horizontal: AppConstants.mediumPadding,
          vertical: AppConstants.gesturePadding),
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.lightGrey,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppConstants.borderRadius),
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(right: 0, left: 5),
          leading: image,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.semi14,
              ),
              Text(
                profession,
                style: TextStyles.regular12,
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.phone,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
