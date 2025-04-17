import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/text_styles.dart';
import 'package:health_care_app/core/utils/buttons/custom_icon_button.dart';
import 'package:health_care_app/features/auth/service/auth_service.dart';

import '../../../config/routes/app_router.dart';
import '../../../core/utils/toasts/custom_toasts.dart';
import 'components/admin_appointments_section.dart';
import 'components/admin_diseases_section.dart';
import 'components/admin_doctors_section.dart';
import 'components/admin_users_section.dart';

@RoutePage()
class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: TextStyles.bold16.copyWith(color: AppColors.drawerText),
        ),
        actions: [
          CustomIconButton(
              icon: Icons.logout,
              onTap: () async {
                final result = await authService.signOut();

                AutoRouter.of(context).replaceAll([const LoginRoute()]);
                CustomToasts.success("Logged Out");
              })
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Users'),
            Tab(text: 'Appointments'),
            Tab(text: 'Diseases'),
            Tab(text: 'Doctors'),
          ],
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.grey,
          indicatorColor: AppColors.primary,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AdminUsersSection(),
          AdminAppointmentsSection(),
          AdminDiseasesSection(),
          AdminDoctorsSection(),
        ],
      ),
    );
  }
}
