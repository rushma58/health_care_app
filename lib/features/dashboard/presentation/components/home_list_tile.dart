import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/text_styles.dart';
import 'package:health_care_app/core/utils/gesture/custom_inkwell.dart';
import 'package:health_care_app/features/dashboard/presentation/components/disease_information_screen.dart';

class HomeListTile extends StatelessWidget {
  final Map<String, dynamic> disease;
  final Widget image;
  final String title;
  const HomeListTile({
    super.key,
    required this.disease,
    this.image = const SizedBox(
      width: 10,
    ),
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiseaseInfoScreen(
              diseaseData: disease,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: 0, horizontal: AppConstants.gesturePadding),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.lightGrey,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppConstants.borderRadius),
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(right: 5, left: 5),
          leading: image,
          title: Text(
            title,
            style: TextStyles.semi14,
          ),
          trailing: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiseaseInfoScreen(
                    diseaseData: disease,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.mediumGrey,
            ),
          ),
        ),
      ),
    );
  }
}
