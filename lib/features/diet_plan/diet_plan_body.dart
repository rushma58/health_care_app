import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/app_spaces.dart';

import 'component/diet_plan_button_section.dart';
import 'component/diet_plan_form_section.dart';
import 'component/user_avatar.dart';

class DietPlanBody extends StatefulWidget {
  const DietPlanBody({super.key});

  @override
  State<DietPlanBody> createState() => _DietPlanBodyState();
}

class _DietPlanBodyState extends State<DietPlanBody> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppConstants.screenPadding),
        child: Column(
          children: [
            UserAvatar(
              name: "Sargat Man Singh",
              position: "User",
            ),
            AppSpaces.large,
            DietPlanFormSection(),
            AppSpaces.large,
            DietPlanButtonSection(),
          ],
        ),
      ),
    );
  }
}
