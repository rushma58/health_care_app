import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';

import '../../../../../../core/utils/buttons/expanded_filled_button.dart';
import '../../../../../config/routes/app_routes.dart';

class RegistrationButtonSection extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  const RegistrationButtonSection({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RegistrationButton(
          email: email,
          password: password,
        ),
      ],
    );
  }
}

// class _ForgotPasswordComponent extends StatelessWidget {
//   const _ForgotPasswordComponent();

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: TappableText(
//         text: 'Forgot Password?',
//         style: TextStyles.regular14.copyWith(
//           color: AppColors.label,
//         ),
//         onTap: () => AutoRouter.of(context).pushNamed(AppRoutes.forgotPassword),
//       ),
//     );
//   }
// }

class _RegistrationButton extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  const _RegistrationButton({
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandedFilledButton(
      isLoading: false,
      backgroundColor: AppColors.primary,
      title: 'Register',
      onTap: () {
        AutoRouter.of(context).pushNamed(AppRoutes.dashboard);
      },
    );
  }
}

class AgreeButton extends StatefulWidget {
  const AgreeButton({super.key});

  @override
  State<AgreeButton> createState() => _AgreeButtonState();
}

class _AgreeButtonState extends State<AgreeButton> {
  @override
  Widget build(BuildContext context) {
    // return Row(
    //   children: [Checkbox(value: "value", onChanged: () {})],
    // );
    return const SizedBox.expand();
  }
}
