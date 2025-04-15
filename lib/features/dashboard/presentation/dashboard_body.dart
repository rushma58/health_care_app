import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_spaces.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_styles.dart';
import 'components/home_list_tile.dart';
import 'components/upcoming_appointments_section.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference get _diseasesRef => _firestore.collection('diseases');
  List<Map<String, dynamic>> diseaseList = [];
  List<Map<String, dynamic>> filteredDiseaseList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    QuerySnapshot snapshot = await _diseasesRef.get();
    setState(() {
      diseaseList = snapshot.docs
          .map(
            (doc) => {
              'id': doc.id,
              'name': doc['name'],
              'meaning': doc['meaning'],
              'symptoms': doc['symptoms'],
              'precautions': doc['precautions'],
            },
          )
          .toList();

      filteredDiseaseList = diseaseList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const UpcomingAppointmentsSection(),
          AppSpaces.large,
          TextFormField(
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyles.regular14.copyWith(color: AppColors.border),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.border,
              ),
              fillColor: AppColors.textFieldBg,
            ),
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  filteredDiseaseList = diseaseList;
                } else {
                  filteredDiseaseList = diseaseList
                      .where((disease) => disease['name']
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                }
              });
            },
          ),
          AppSpaces.large,
          ListView.separated(
            itemCount: filteredDiseaseList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return AppSpaces.small;
            },
            itemBuilder: (context, index) {
              return HomeListTile(
                image: const Iconify(MaterialSymbols.health_and_safety_outline),
                title: filteredDiseaseList[index]['name'],
                disease: filteredDiseaseList[index],
              );
            },
          ),
          AppSpaces.large,
        ],
      ),
    );
  }
}
