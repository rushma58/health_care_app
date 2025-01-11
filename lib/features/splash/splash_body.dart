import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../config/routes/app_routes.dart';
import '../../core/constants/app_colors.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () => _handleChanges(context));
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Center(
        child: Icon(
          Icons.health_and_safety,
          color: AppColors.danger,
          size: 400,
        ),
      ),
    );
  }

  void _handleChanges(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      if (context.mounted) {
        context.router.replaceNamed(AppRoutes.login);
      }
    });
  }
}
