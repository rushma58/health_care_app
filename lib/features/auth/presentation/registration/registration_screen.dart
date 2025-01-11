import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/gesture/custom_gesture_detector.dart';
import '../../../../core/constants/app_colors.dart';
import 'registration_body.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget implements AutoRouteWrapper {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return const CustomGestureDetector(
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: RegistrationBody(),
        ),
      ),
    );
  }
}
