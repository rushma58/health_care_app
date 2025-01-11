import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/app_spaces.dart';
import 'package:health_care_app/core/constants/text_styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';

import '../../../core/infrastructure/resources/assets.dart';
import 'component/call_doctor_tile.dart';

class CallDoctorBody extends StatefulWidget {
  const CallDoctorBody({super.key});

  @override
  State<CallDoctorBody> createState() => _CallDoctorBodyState();
}

class _CallDoctorBodyState extends State<CallDoctorBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.screenPadding),
        child: Column(
          children: [
            const Iconify(
              Ph.first_aid_fill,
              size: 100,
              color: AppColors.grey,
            ),
            AppSpaces.large,
            CallDoctorTile(
              image: Image.asset(Assets.doctor1Image),
              title: "Dr. Niraj Joshi",
              profession: "ENT",
            ),
            CallDoctorTile(
              image: Image.asset(Assets.doctor2Image),
              title: "Prof. Dr. Kishor Sharma",
              profession: "Cardiologists",
            ),
            CallDoctorTile(
              image: Image.asset(Assets.doctor3Image),
              title: "Dr. Bijay Joshi",
              profession: "Dermatologists",
            ),
            CallDoctorTile(
              image: Image.asset(Assets.doctor4Image),
              title: "MD Dr. Shyam Chaudhary",
              profession: "Gastroenteroiogists",
            ),
            CallDoctorTile(
              image: Image.asset(Assets.doctor5Image),
              title: "Dr. Prem Joshi",
              profession: "Neurologists",
            ),
            Text(
              "More",
              style: TextStyles.regular12.copyWith(color: AppColors.primary),
            )
          ],
        ),
      ),
    );
  }
}
