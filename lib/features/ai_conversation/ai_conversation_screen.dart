import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/app_spaces.dart';
import 'package:health_care_app/core/constants/text_styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';

import '../../../core/utils/app_bars/custom_app_bar.dart';

@RoutePage()
class AiConversationScreen extends StatefulWidget implements AutoRouteWrapper {
  const AiConversationScreen({super.key});

  @override
  State<AiConversationScreen> createState() => _AiConversationScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

class _AiConversationScreenState extends State<AiConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(
          title: 'AI Conversation',
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppConstants.screenPadding),
          child: Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: AppConstants.mediumAvatarSize,
                  backgroundColor: AppColors.secondary,
                  child: Iconify(
                    MaterialSymbols.magic_button,
                    size: AppConstants.authIconSize,
                    color: AppColors.primary,
                  ),
                ),
                AppSpaces.large,
                Text(
                  "Coming Soon",
                  style: TextStyles.bold16.copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
