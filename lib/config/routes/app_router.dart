import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/features/auth/presentation/registration/registration_screen.dart';
import 'package:health_care_app/features/diet_plan/diet_plan_list/diet_plan_list_screen.dart';

import '../../features/ai_conversation/ai_conversation_screen.dart';
import '../../features/auth/presentation/login/ui/login_screen.dart';
import '../../features/booking/booking_screen.dart';
import '../../features/call/call_doctor_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/diet_plan/diet_plan_screen.dart';
import '../../features/diet_plan/diet_response/diet_response_screen.dart';
import '../../features/splash/splash_screen.dart';
import 'app_routes.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        ..._authRoutes,
        ..._dashboardRoutes,
      ];

  late final List<AutoRoute> _authRoutes = [
    // ** Splash
    _autoRoute(
      path: AppRoutes.splash,
      page: SplashRoute.page,
    ),

    _autoRoute(
      path: AppRoutes.login,
      page: LoginRoute.page,
    ),

    _autoRoute(
      path: AppRoutes.register,
      page: RegistrationRoute.page,
    ),
  ];

  late final List<AutoRoute> _dashboardRoutes = [
    _autoRoute(
      path: AppRoutes.dashboard,
      page: DashboardRoute.page,
    ),
    _autoRoute(
      path: AppRoutes.callDoctor,
      page: CallDoctorRoute.page,
    ),
    _autoRoute(
      path: AppRoutes.booking,
      page: BookingRoute.page,
    ),
    _autoRoute(
      path: AppRoutes.aiConversation,
      page: AiConversationRoute.page,
    ),
    _autoRoute(
      path: AppRoutes.dietPlan,
      page: DietPlanRoute.page,
    ),
    _autoRoute(
      path: AppRoutes.dietPlan,
      page: DietPlanRoute.page,
    ),
    _autoRoute(
      path: AppRoutes.dietPlanResponse,
      page: DietResponseRoute.page,
    ),
    _autoRoute(
      path: AppRoutes.dietPlanList,
      page: DietPlanListRoute.page,
    ),
  ];

  AutoRoute _autoRoute({
    required String? path,
    required PageInfo page,
    List<AutoRoute>? children,
    bool useDefaultTransition = false,
  }) =>
      CustomRoute(
        path: path,
        page: page,
        children: children,
        transitionsBuilder:
            useDefaultTransition ? null : TransitionsBuilders.slideLeft,
      );
}
