import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';

import '../../../../../../core/utils/gesture/custom_gesture_detector.dart';
import '../../core/utils/app_bars/custom_app_bar.dart';
import 'booking_body.dart';

@RoutePage()
class BookingScreen extends StatefulWidget implements AutoRouteWrapper {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return const CustomGestureDetector(
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          title: 'Doctor Appointment',
        ),
        body: SafeArea(
          child: BookingBody(),
        ),
      ),
    );
  }
}
