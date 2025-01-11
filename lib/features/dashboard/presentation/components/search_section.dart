import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/text_styles.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.screenPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle:
                    TextStyles.regular14.copyWith(color: AppColors.border),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.border,
                ),
                fillColor: AppColors.textFieldBg,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_list_rounded,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
