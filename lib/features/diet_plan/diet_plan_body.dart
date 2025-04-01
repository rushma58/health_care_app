import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/app_spaces.dart';
import 'package:health_care_app/features/auth/service/auth/auth_bloc.dart';
import 'package:health_care_app/features/auth/service/auth/auth_state.dart';

import 'component/diet_plan_button_section.dart';
import 'component/diet_plan_form_section.dart';
import 'component/user_avatar.dart';

class DietPlanBody extends StatefulWidget {
  const DietPlanBody({super.key});

  @override
  State<DietPlanBody> createState() => _DietPlanBodyState();
}

class _DietPlanBodyState extends State<DietPlanBody> {
  String? apiKey;
  final gender = TextEditingController();
  final height = TextEditingController();
  final weight = TextEditingController();
  final activityLevel = TextEditingController();
  final foodPreferences = TextEditingController();

  @override
  void initState() {
    getAPIKey();
    super.initState();
  }

  @override
  void dispose() {
    gender.dispose();
    height.dispose();
    weight.dispose();
    activityLevel.dispose();
    foodPreferences.dispose();
    super.dispose();
  }

  Future<void> getAPIKey() async {
    await dotenv.load(fileName: ".env");
    apiKey = dotenv.env['GEMINI_API_KEY'] ?? 'API key not found';
    debugPrint('API Key: $apiKey');
    if (apiKey == "") {
      debugPrint('API Key is empty!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.screenPadding),
        child: Column(
          children: [
            BlocSelector<AuthBloc, AuthState, AuthState>(
              selector: (state) => state,
              builder: (context, state) => UserAvatar(
                name: state.userData?["displayName"] ?? '',
                position: state.user?.email ?? '',
              ),
            ),
            AppSpaces.large,
            DietPlanFormSection(
              gender: gender,
              weight: weight,
              height: height,
              activityLevel: activityLevel,
              foodPreferences: foodPreferences,
            ),
            AppSpaces.large,
            DietPlanButtonSection(
              gender: gender,
              weight: weight,
              height: height,
              activityLevel: activityLevel,
              foodPreferences: foodPreferences,
              apiKey: apiKey ?? '',
            ),
          ],
        ),
      ),
    );
  }
}
