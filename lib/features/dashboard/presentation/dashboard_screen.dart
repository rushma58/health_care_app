import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/features/dashboard/presentation/dashboard_drawer.dart';

import '../../../core/utils/app_bars/custom_app_bar.dart';
import '../../../core/utils/buttons/custom_icon_button.dart';
import 'dashboard_body.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget implements AutoRouteWrapper {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        drawer: const DashboardDrawer(),
        appBar: CustomAppBar(
          title: 'HOME',
          leading: Builder(
            builder: (context) => CustomIconButton(
              icon: Icons.menu,
              onTap: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(12.0),
          child: DashboardBody(),
        ),
      ),
    );
  }
}
