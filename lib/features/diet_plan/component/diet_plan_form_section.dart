import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TextEditingController disease;
  const DietPlanFormSection({
    super.key,
    required this.gender,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.foodPreferences,
    required this.disease,
  });

  @override
  State<DietPlanFormSection> createState() => _DietPlanFormSectionState();
}

class _DietPlanFormSectionState extends State<DietPlanFormSection> {
  late List<String> genderList;
  late List<String> activityLevelList;
  late List<String> foodPreferenceList;
  late List<String> diseaseList = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference get _diseasesRef => _firestore.collection('diseases');
  @override
  void initState() {
    super.initState();
    fetchData();
    genderList = ["Male", "Female", "Others"];
    activityLevelList = ["Regularly Exercise", "Rarely Exercise"];
    foodPreferenceList = ["Vegeterian", "Non Vegeterian"];
  }

  void fetchData() async {
    QuerySnapshot snapshot = await _diseasesRef.get();
    setState(() {
      diseaseList = snapshot.docs.map((doc) => doc['name'].toString()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdownInput<String?>(
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
          value: null,
          onChanged: (p0) {
            widget.gender.text = p0!;
          },
        ),
        AppSpaces.medium,
        CustomInput(
          label: 'Height',
          hint: 'Enter Height (in ft)',
          isPassword: false,
          controller: widget.height,
          textInputType: TextInputType.text,
          validator: (value) =>
              ValidationHelper.checkEmptyField(value, field: 'height'),
        ),
        AppSpaces.medium,
        CustomInput(
          label: 'Weight',
          hint: 'Enter Weight (in kg)',
          controller: widget.weight,
          textInputType: TextInputType.text,
          validator: (value) =>
              ValidationHelper.checkEmptyField(value, field: 'weight'),
        ),
        AppSpaces.medium,
        CustomDropdownInput<String?>(
          label: "Activity Level",
          hint: "Select Activity Level",
          items: activityLevelList
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          value: null,
          onChanged: (p0) {
            widget.activityLevel.text = p0!;
          },
        ),
        AppSpaces.medium,
        CustomDropdownInput<String?>(
          label: "Food Preferences",
          hint: "Select Food Preferences",
          items: foodPreferenceList
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          value: null,
          onChanged: (p0) {
            widget.foodPreferences.text = p0!;
          },
        ),
        AppSpaces.medium,
        CustomDropdownInput<String?>(
          label: "Disease",
          hint: "Select Disease",
          items: diseaseList
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          value: null,
          onChanged: (p0) {
            widget.disease.text = p0!;
          },
        ),
      ],
    );
  }
}
