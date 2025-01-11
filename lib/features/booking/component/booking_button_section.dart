import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/utils/toasts/custom_toasts.dart';

import '../../../../../../core/constants/app_spaces.dart';
import '../../../../../../core/utils/buttons/expanded_filled_button.dart';

class BookingButtonSection extends StatelessWidget {
  const BookingButtonSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AppSpaces.veryLarge,
        _BookingButtom(),
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

class _BookingButtom extends StatelessWidget {
  const _BookingButtom();

  @override
  Widget build(BuildContext context) {
    return ExpandedFilledButton(
      isLoading: false,
      backgroundColor: AppColors.primary,
      title: 'Book An Appointment',
      onTap: () {
        // AutoRouter.of(context).pushNamed(AppRoutes.dashboard);

        CustomToasts.success("Thank You");
      },
    );
  }
}
