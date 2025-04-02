import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';

import '../../../core/utils/app_bars/custom_app_bar.dart';
import 'diet_plan_body.dart';

@RoutePage()
class DietPlanScreen extends StatefulWidget implements AutoRouteWrapper {
  const DietPlanScreen({super.key});

  @override
  State<DietPlanScreen> createState() => _DietPlanScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

class _DietPlanScreenState extends State<DietPlanScreen> {
  //TODO
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          title: 'Diet Plan',
        ),
        body: DietPlanBody(),
      ),
    );
  }
}
