// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AiConversationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const AiConversationScreen()),
      );
    },
    BookingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const BookingScreen()),
      );
    },
    CallDoctorRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CallDoctorScreen()),
      );
    },
    DashboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const DashboardScreen()),
      );
    },
    DietPlanListRoute.name: (routeData) {
      final args = routeData.argsAs<DietPlanListRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DietPlanListScreen(
          key: args.key,
          dietList: args.dietList,
        ),
      );
    },
    DietPlanRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const DietPlanScreen()),
      );
    },
    DietResponseRoute.name: (routeData) {
      final args = routeData.argsAs<DietResponseRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DietResponseScreen(
          key: args.key,
          dietResponse: args.dietResponse,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const LoginScreen()),
      );
    },
    RegistrationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const RegistrationScreen()),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [AiConversationScreen]
class AiConversationRoute extends PageRouteInfo<void> {
  const AiConversationRoute({List<PageRouteInfo>? children})
      : super(
          AiConversationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AiConversationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BookingScreen]
class BookingRoute extends PageRouteInfo<void> {
  const BookingRoute({List<PageRouteInfo>? children})
      : super(
          BookingRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CallDoctorScreen]
class CallDoctorRoute extends PageRouteInfo<void> {
  const CallDoctorRoute({List<PageRouteInfo>? children})
      : super(
          CallDoctorRoute.name,
          initialChildren: children,
        );

  static const String name = 'CallDoctorRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DashboardScreen]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DietPlanListScreen]
class DietPlanListRoute extends PageRouteInfo<DietPlanListRouteArgs> {
  DietPlanListRoute({
    Key? key,
    required List<Map<String, dynamic>> dietList,
    List<PageRouteInfo>? children,
  }) : super(
          DietPlanListRoute.name,
          args: DietPlanListRouteArgs(
            key: key,
            dietList: dietList,
          ),
          initialChildren: children,
        );

  static const String name = 'DietPlanListRoute';

  static const PageInfo<DietPlanListRouteArgs> page =
      PageInfo<DietPlanListRouteArgs>(name);
}

class DietPlanListRouteArgs {
  const DietPlanListRouteArgs({
    this.key,
    required this.dietList,
  });

  final Key? key;

  final List<Map<String, dynamic>> dietList;

  @override
  String toString() {
    return 'DietPlanListRouteArgs{key: $key, dietList: $dietList}';
  }
}

/// generated route for
/// [DietPlanScreen]
class DietPlanRoute extends PageRouteInfo<void> {
  const DietPlanRoute({List<PageRouteInfo>? children})
      : super(
          DietPlanRoute.name,
          initialChildren: children,
        );

  static const String name = 'DietPlanRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DietResponseScreen]
class DietResponseRoute extends PageRouteInfo<DietResponseRouteArgs> {
  DietResponseRoute({
    Key? key,
    required Map<String, dynamic> dietResponse,
    List<PageRouteInfo>? children,
  }) : super(
          DietResponseRoute.name,
          args: DietResponseRouteArgs(
            key: key,
            dietResponse: dietResponse,
          ),
          initialChildren: children,
        );

  static const String name = 'DietResponseRoute';

  static const PageInfo<DietResponseRouteArgs> page =
      PageInfo<DietResponseRouteArgs>(name);
}

class DietResponseRouteArgs {
  const DietResponseRouteArgs({
    this.key,
    required this.dietResponse,
  });

  final Key? key;

  final Map<String, dynamic> dietResponse;

  @override
  String toString() {
    return 'DietResponseRouteArgs{key: $key, dietResponse: $dietResponse}';
  }
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegistrationScreen]
class RegistrationRoute extends PageRouteInfo<void> {
  const RegistrationRoute({List<PageRouteInfo>? children})
      : super(
          RegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
