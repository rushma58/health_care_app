import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/app_spaces.dart';
import 'package:health_care_app/core/constants/text_styles.dart';

import '../../../core/infrastructure/resources/assets.dart';
import 'components/home_list_tile.dart';
import 'components/search_Section.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SearchSection(),
          Text(
            "DISEASES",
            style: TextStyles.bold18.copyWith(color: AppColors.black),
          ),
          AppSpaces.large,
          HomeListTile(
            image: Image.asset(Assets.diabetesImage),
            title: "Diabetes",
          ),
          HomeListTile(
            image: Image.asset(Assets.thyroidImage),
            title: "Thyroid",
          ),
          HomeListTile(
            image: Image.asset(Assets.cancerImage),
            title: "Cancer",
          ),
          HomeListTile(
            image: Image.asset(Assets.bloodPressureImage),
            title: "Blood Pressure",
          ),
          HomeListTile(
            image: Image.asset(Assets.constipationImage),
            title: "Constipation",
          ),
          HomeListTile(
            image: Image.asset(Assets.covidImage),
            title: "Covid-19",
          ),
          HomeListTile(
            image: Image.asset(Assets.dengueImage),
            title: "Dengue",
          ),
        ],
      ),
    );
  }
}
