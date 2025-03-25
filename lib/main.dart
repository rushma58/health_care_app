import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/features/auth/service/auth/auth_bloc.dart';
import 'package:health_care_app/firebase_options.dart';

import 'config/routes/app_router.dart';
import 'config/theme/app_themes.dart';
import 'features/auth/service/auth/auth_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authBloc = AuthBloc();
  authBloc.add(LoadUserFromPrefs());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp.router(
        title: AppConstants.appName,
        theme: AppThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
