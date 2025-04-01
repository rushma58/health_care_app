import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/config/routes/app_routes.dart';
import 'package:health_care_app/core/constants/app_spaces.dart';
import 'package:health_care_app/core/constants/text_styles.dart';
import 'package:health_care_app/features/auth/service/auth/auth_state.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/toasts/custom_toasts.dart';
import '../../auth/service/auth/auth_bloc.dart';
import '../../auth/service/auth_service.dart';
import 'components/drawer_tile.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Drawer(
        backgroundColor: AppColors.lightGrey,
        width: size.width * 0.7,
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              width: double.infinity,
              child: BlocSelector<AuthBloc, AuthState, AuthState?>(
                  selector: (state) => state,
                  builder: (context, state) {
                    return DrawerHeader(
                      decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "HEALTH CARE",
                            style: TextStyles.bold24
                                .copyWith(color: AppColors.lightGrey),
                          ),
                          AppSpaces.large,
                          const CircleAvatar(
                            backgroundColor: AppColors.lightGrey,
                            radius: 30,
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: AppColors.grey,
                            ),
                          ),
                          AppSpaces.medium,
                          Text(
                            state?.displayName ?? '',
                            style: TextStyles.bold18
                                .copyWith(color: AppColors.lightGrey),
                          ),
                          Text(
                            state?.user?.email ?? '',
                            style: TextStyles.regular16
                                .copyWith(color: AppColors.lightGrey),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: ListView(
                children: [
                  DrawerTile(
                    icon: Icons.home,
                    title: "Home",
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                    },
                  ),
                  DrawerTile(
                    icon: Icons.chat,
                    title: "AI Conversation",
                    onTap: () {
                      AutoRouter.of(context)
                          .pushNamed(AppRoutes.aiConversation);
                    },
                  ),
                  DrawerTile(
                    icon: Icons.handshake,
                    title: "Doctor Appointment",
                    onTap: () {
                      AutoRouter.of(context).pushNamed(AppRoutes.booking);
                    },
                  ),
                  DrawerTile(
                    icon: Icons.phone,
                    title: "Call a Doctor",
                    onTap: () {
                      AutoRouter.of(context).pushNamed(AppRoutes.callDoctor);
                    },
                  ),
                  DrawerTile(
                    icon: Icons.file_copy,
                    title: "Diet Plan",
                    onTap: () {
                      AutoRouter.of(context).pushNamed(AppRoutes.dietPlan);
                    },
                  ),
                  DrawerTile(
                    icon: Icons.people,
                    title: "Logout",
                    onTap: () async {
                      final result = await authService.signOut();
                      AutoRouter.of(context).pushNamed(AppRoutes.login);
                      CustomToasts.success("Logged Out");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
