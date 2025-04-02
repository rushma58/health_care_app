import 'dart:convert';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:health_care_app/config/routes/app_router.dart';
import 'package:health_care_app/core/constants/app_colors.dart';

import '../../../../../../core/constants/app_spaces.dart';
import '../../../../../../core/utils/buttons/expanded_filled_button.dart';

class DietPlanButtonSection extends StatefulWidget {
  final TextEditingController gender;
  final TextEditingController height;
  final TextEditingController weight;
  final TextEditingController activityLevel;
  final TextEditingController foodPreferences;
  final TextEditingController disease;
  final String apiKey;
  const DietPlanButtonSection({
    super.key,
    required this.gender,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.foodPreferences,
    required this.disease,
    required this.apiKey,
  });

  @override
  State<DietPlanButtonSection> createState() => _DietPlanButtonSectionState();
}

class _DietPlanButtonSectionState extends State<DietPlanButtonSection> {
  late bool isLoading = false;
  String dietResponse = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String cleanJsonString(String rawInput) {
    // First, remove markdown code block delimiters if they exist
    String cleanedJson =
        rawInput.replaceAll('```json', '').replaceAll('```', '').trim();

    // Find the position of the last closing brace (end of JSON)
    int lastBraceIndex = cleanedJson.lastIndexOf('}');

    // If we found a closing brace, extract everything up to and including it
    if (lastBraceIndex != -1) {
      cleanedJson = cleanedJson.substring(0, lastBraceIndex + 1);
    }

    // Alternative approach: regex to extract just the JSON object
    // Pattern pattern = RegExp(r'\{.*\}', dotAll: true);
    // Match? match = pattern.firstMatch(cleanedJson);
    // if (match != null) {
    //   cleanedJson = match.group(0) ?? cleanedJson;
    // }

    return cleanedJson.trim();
  }

  // Method to store diet data in Firebase
  Future<void> storeDietPlanToFirebase(Map<String, dynamic> dietData) async {
    try {
      // Get current user
      final User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Add timestamp and user info to the data
        dietData['timestamp'] = FieldValue.serverTimestamp();
        dietData['userId'] = currentUser.uid;

        // Store in Firestore under user's collection
        await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .collection('diet_plans')
            .add(dietData);

        log('Diet plan stored successfully in Firebase');
      } else {
        log('Error: No user is currently signed in');
      }
    } catch (e) {
      log('Error storing diet plan in Firebase: $e');
    }
  }

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
            String disease = widget.disease.text;
            const instruction =
                'Provide me diet plan for the following condition. Include foods to have, foods to avoid and a week of diet plan.';
            const provideInJson =
                " i need response in json format only i dont need any other text beside pure json. the first character should be bracket and nothing more. {'disease_to_tackle': disease_name...,'foods_to_have':[ {'food':..,'reason':..},{},...], 'foods_to_avoid':[ {'food':..,'reason':..},{},...], 'weekly_diet':[ {'day':..,'breakfast':..,'lunch':..,'dinner':..},{},...]}";
            final data =
                'Gender - $gender, Height - $height feet,Weight - $weight kg,Activity Level - $activityLevel,Food Preference - $foodPreferences,Disease - $disease';
            final model = GenerativeModel(
                model: 'gemini-1.5-flash', apiKey: widget.apiKey);

            final prompt = instruction + provideInJson + data;
            final content = [Content.text(prompt)];
            log("AI Content: $content");
            log("AI API KEY: ${widget.apiKey}");
            try {
              final response = await model.generateContent(content);
              log("AI Response: ${response.text}");

              String rawResponse = response.text ?? '';

              String cleanJson = cleanJsonString(rawResponse);

              Map<String, dynamic> dietData = json.decode(cleanJson);

              // Store the diet data in Firebase
              await storeDietPlanToFirebase(dietData);

              // Add user profile data to the diet plan
              dietData['user_profile'] = {
                'gender': gender,
                'height': height,
                'weight': weight,
                'activity_level': activityLevel,
                'food_preferences': foodPreferences,
                'disease': disease,
              };

              AutoRouter.of(context)
                  .push(DietResponseRoute(dietResponse: dietData));

              setState(() {
                dietResponse = response.text ?? 'No comparison available';
                isLoading = false;
              });
            } catch (e) {
              log('Error generating content: $e');
              setState(() {
                isLoading = false;
              });
              // Show error dialog or snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to generate diet plan: $e')),
              );
            }
          },
        ),
      ],
    );
  }
}
