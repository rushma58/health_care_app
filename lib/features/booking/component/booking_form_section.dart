import 'package:flutter/material.dart';
import 'package:health_care_app/core/utils/inputs/custom_date_input.dart';

import '../../../core/constants/app_spaces.dart';
import '../../../core/helpers/validation_helper.dart';
import '../../../core/utils/inputs/custom_input.dart';

class BookingFormSection extends StatefulWidget {
  final TextEditingController date;
  final TextEditingController doctor;
  final TextEditingController symptoms;

  const BookingFormSection({
    super.key,
    required this.date,
    required this.doctor,
    required this.symptoms,
  });

  @override
  State<BookingFormSection> createState() => _BookingFormSectionState();
}

class _BookingFormSectionState extends State<BookingFormSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDateInput(
          hint: 'Enter Date',
          label: 'Date',
          controller: widget.date,
        ),
        AppSpaces.medium,
        CustomInput(
          label: 'Doctor',
          hint: 'Enter Doctor',
          isPassword: false,
          controller: widget.doctor,
          textInputType: TextInputType.text,
          validator: (value) =>
              ValidationHelper.checkEmptyField(value, field: 'doctor'),
        ),
        AppSpaces.medium,
        CustomInput(
          label: 'Symptoms',
          hint: 'Enter Symptoms',
          controller: widget.symptoms,
          textInputType: TextInputType.multiline,
          validator: (value) =>
              ValidationHelper.checkEmptyField(value, field: 'symptoms'),
        ),
      ],
    );
  }
}
