import 'package:flutter/material.dart';
import 'package:health_care_app/core/utils/inputs/custom_dropdown_input.dart';

import '../../../core/constants/app_spaces.dart';
import '../../../core/helpers/validation_helper.dart';
import '../../../core/utils/inputs/custom_input.dart';

class DietPlanFormSection extends StatefulWidget {
  final TextEditingController gender;
  final TextEditingController height;
  final TextEditingController weight;
  final TextEditingController activityLevel;
  final TextEditingController foodPreferences;
  const DietPlanFormSection({
    super.key,
    required this.gender,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.foodPreferences,
  });

  @override
  State<DietPlanFormSection> createState() => _DietPlanFormSectionState();
}

class _DietPlanFormSectionState extends State<DietPlanFormSection> {
  late List<String> genderList;
  @override
  void initState() {
    super.initState();
    genderList = ["Male", "Female", "Others"];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdownInput<String>(
          label: "Gender",
          hint: "Select Gender",
          items: genderList
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          value: genderList.first,
          onChanged: (p0) {
            widget.gender.text = p0;
          },
        ),
        AppSpaces.medium,
        CustomInput(
          label: 'Height',
          hint: 'Enter Height (in cm)',
          isPassword: false,
          controller: widget.height,
          textInputType: TextInputType.text,
          validator: (value) =>
              ValidationHelper.checkEmptyField(value, field: 'height'),
        ),
        AppSpaces.medium,
        CustomInput(
          label: 'Weight',
          hint: 'Enter Weight',
          controller: widget.weight,
          textInputType: TextInputType.text,
          validator: (value) =>
              ValidationHelper.checkEmptyField(value, field: 'weight'),
        ),
        AppSpaces.medium,
        CustomInput(
          label: 'Activity Level',
          hint: 'Activity Level',
          controller: widget.activityLevel,
          textInputType: TextInputType.text,
          validator: (value) =>
              ValidationHelper.checkEmptyField(value, field: 'activity_level'),
        ),
        AppSpaces.medium,
        CustomInput(
          label: 'Food Preferences',
          hint: 'Food Preferences',
          controller: widget.foodPreferences,
          textInputType: TextInputType.multiline,
          validator: (value) => ValidationHelper.checkEmptyField(value,
              field: 'food_preferences'),
        ),
      ],
    );
  }
}
