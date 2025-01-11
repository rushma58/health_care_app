import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_constants.dart';

class AuthTopSpace extends StatelessWidget {
  const AuthTopSpace({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: height * AppConstants.spaceTopSpaceFactor,
    );
  }
}
