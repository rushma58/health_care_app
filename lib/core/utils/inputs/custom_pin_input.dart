import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../../../core/helpers/validation_helper.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../constants/text_styles.dart';

class PinInput extends StatefulWidget {
  final TextEditingController controller;
  const PinInput({
    super.key,
    required this.controller,
  });

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  String? errorText;
  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: widget.controller,
      length: 6,
      defaultPinTheme: PinTheme(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            width: 1,
            color: AppColors.inputBorder,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppConstants.borderRadius),
          ),
        ),
        textStyle: TextStyles.regular16.copyWith(
          color: AppColors.lightText,
        ),
      ),
      errorPinTheme: PinTheme(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            width: 1,
            color: AppColors.danger,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppConstants.borderRadius),
          ),
        ),
        textStyle: TextStyles.regular16.copyWith(
          color: AppColors.lightText,
        ),
      ),
      errorText: errorText,
      pinputAutovalidateMode: PinputAutovalidateMode.disabled,
      errorTextStyle: errorText == null
          ? TextStyles.medium12.copyWith(
              color: Colors.red[900],
            )
          : const TextStyle(fontSize: 0),
      validator: (value) => ValidationHelper.otpValidator(value ?? ''),
    );
  }
}
