import 'package:flutter/material.dart';
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
            // setState(() {
            //   isLoading = true;
            // });
            // String shoe1 = shoe1Controller.text;
            // String shoe2 = shoe2Controller.text;
            // final model = GenerativeModel(
            //     model: 'gemini-1.5-flash', apiKey: widget.apiKey);

            // final prompt =
            //     "Compare $shoe1 and $shoe2 by Performance (lightness, cushioning, flexibility, responsive, stability, grip) and rate it out of 10 where 10 is excellent and 0 is worst, strike, price and then provide the verdicts according to it on which shoe to buy.";
            // final content = [Content.text(prompt)];
            // try {
            //   final response = await model.generateContent(content);
            //   debugPrint(response.text);

            //   setState(() {
            //     comparisonResult = response.text ?? 'No comparison available';
            //     isLoading = false;
            //   });
            // } catch (e) {
            //   debugPrint('Error generating content: $e');
            // }
          },
        ),
      ],
    );
  }
}
