import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:health_care_app/core/constants/app_colors.dart';

import '../../../../../../core/constants/app_spaces.dart';
import '../../../../../../core/utils/buttons/expanded_filled_button.dart';

class DietPlanButtonSection extends StatefulWidget {
  final TextEditingController gender;
  final TextEditingController height;
  final TextEditingController weight;
  final TextEditingController activityLevel;
  final TextEditingController foodPreferences;
  final String apiKey;
  const DietPlanButtonSection({
    super.key,
    required this.gender,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.foodPreferences,
    required this.apiKey,
  });

  @override
  State<DietPlanButtonSection> createState() => _DietPlanButtonSectionState();
}

class _DietPlanButtonSectionState extends State<DietPlanButtonSection> {
  late bool isLoading = false;
  String dietResponse = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpaces.veryLarge,
        ExpandedFilledButton(
          isLoading: isLoading,
          backgroundColor: AppColors.primary,
          title: 'Create a Diet Plan',
          onTap: () async {
            setState(() {
              isLoading = true;
            });
            String gender = widget.gender.text;
            String height = widget.height.text;
            String weight = widget.weight.text;
            String activityLevel = widget.activityLevel.text;
            String foodPreferences = widget.foodPreferences.text;
            const instruction =
                'Provide me diet plan for the following condition. Include foods to have, foods to avoid and a week of diet plan.';
            const provideInJson =
                " i need response in json format only i dont need any other text beside json. {'foods_to_have':[ {'food':..,'reason':..},{},...], 'foods_to_avoid':[ {'food':..,'reason':..},{},...], 'weekly_diet':[ {'day':..,'breakfast':..,'lunch':..,'dinner':..},{},...]}";
            final data =
                'Gender - $gender, Height - $height feet,Weight - $weight kg,Activity Level - $activityLevel,Food Preference - $foodPreferences,Disease - Cough cold and fever';
            final model = GenerativeModel(
                model: 'gemini-1.5-flash', apiKey: widget.apiKey);

            final prompt = instruction + provideInJson + data;
            final content = [Content.text(prompt)];
            log("AI Content: $content");
            log("AI API KEY: ${widget.apiKey}");
            try {
              final response = await model.generateContent(content);
              log("AI Response: ${response.text}");

              setState(() {
                dietResponse = response.text ?? 'No comparison available';
                isLoading = false;
              });
            } catch (e) {
              log('Error generating content: $e');
              setState(() {
                isLoading = false;
              });
            }
          },
        ),
      ],
    );
  }
}
