import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/features/call/call_doctor_body.dart';

import '../../../core/utils/app_bars/custom_app_bar.dart';

@RoutePage()
class CallDoctorScreen extends StatefulWidget implements AutoRouteWrapper {
  const CallDoctorScreen({super.key});

  @override
  State<CallDoctorScreen> createState() => _CallDoctorScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

class _CallDoctorScreenState extends State<CallDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Call a Doctor',
      ),
      body: SafeArea(child: CallDoctorBody()),
    );
  }
}
