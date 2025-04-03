import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/text_styles.dart';
import 'package:health_care_app/features/booking/component/booking_button_section.dart';
import 'package:health_care_app/features/booking/component/booking_form_section.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/healthicons.dart';

import '../../../../../../core/constants/app_constants.dart';
import '../../../../../../core/constants/app_spaces.dart';

class BookingBody extends StatefulWidget {
  const BookingBody({super.key});

  @override
  State<BookingBody> createState() => _BookingBodyState();
}

class _BookingBodyState extends State<BookingBody> {
  final _date = TextEditingController();
  final _doctor = TextEditingController();
  final _symptoms = TextEditingController();

  @override
  void dispose() {
    _date.dispose();
    _doctor.dispose();
    _symptoms.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.screenPadding),
      child: Center(
        child: Form(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Iconify(
                Healthicons.doctor_male,
                color: AppColors.grey,
                size: AppConstants.largeAvatarSize,
              ),
              Text(
                "Book an Appointment",
                style: TextStyles.bold18.copyWith(color: AppColors.drawerText),
              ),
              AppSpaces.veryLarge,
              BookingFormSection(
                doctor: _doctor,
                date: _date,
                symptoms: _symptoms,
              ),
              AppSpaces.medium,
              BookingButtonSection(
                doctor: _doctor,
                date: _date,
                symptoms: _symptoms,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
