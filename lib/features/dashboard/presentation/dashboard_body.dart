import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_spaces.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_styles.dart';
import 'components/home_list_tile.dart';

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
              log(">>>>>>>>>>>>>>>>>>>>$value");
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
          ListView.builder(
            itemCount: filteredDiseaseList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return HomeListTile(
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
