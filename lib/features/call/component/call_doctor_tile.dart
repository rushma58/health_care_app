import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/text_styles.dart';
import 'package:health_care_app/core/utils/toasts/custom_toasts.dart';
import 'package:url_launcher/url_launcher.dart';

class CallDoctorTile extends StatelessWidget {
  final Widget image;
  final String title;
  final String profession;
  final String contactNumber;
  const CallDoctorTile({
    super.key,
    required this.image,
    required this.title,
    required this.profession,
    required this.contactNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          // horizontal: AppConstants.mediumPadding,
          vertical: AppConstants.gesturePadding),
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.lightGrey,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppConstants.borderRadius),
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(right: 0, left: 5),
          leading: image,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.semi14,
              ),
              Text(
                profession,
                style: TextStyles.regular12,
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () async {
              _makePhoneCall(contactNumber);
            },
            icon: const Icon(
              Icons.phone,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
        CustomToasts.success("THIS IS A DUMMY DATA");
      }
    } catch (e) {
      debugPrint('Error launching phone call: $e');
      CustomToasts.failure("Try Again Later");
    }
  }
}
