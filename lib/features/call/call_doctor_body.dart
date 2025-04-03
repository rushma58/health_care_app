import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/app_spaces.dart';
import 'package:health_care_app/core/constants/text_styles.dart';
import 'package:health_care_app/core/utils/gesture/custom_inkwell.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fontisto.dart';
import 'package:iconify_flutter/icons/ph.dart';

import '../../../core/infrastructure/resources/assets.dart';
import 'component/call_doctor_tile.dart';

class CallDoctorBody extends StatefulWidget {
  const CallDoctorBody({super.key});

  @override
  State<CallDoctorBody> createState() => _CallDoctorBodyState();
}

class _CallDoctorBodyState extends State<CallDoctorBody> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _doctorsList = [];
  bool _isLoading = true;
  bool _showAllDoctors = false;
  final int _initialDoctorsCount = 5;

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('doctors').get();

      setState(() {
        _doctorsList = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      log('Error fetching doctors: $e');
    }
  }

  List<Map<String, dynamic>> get _displayedDoctors {
    if (_showAllDoctors) {
      return _doctorsList;
    } else {
      return _doctorsList.length > _initialDoctorsCount
          ? _doctorsList.sublist(0, _initialDoctorsCount)
          : _doctorsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Iconify(
              Ph.first_aid_fill,
              size: 100,
              color: AppColors.grey,
            ),
            AppSpaces.large,
            if (_isLoading)
              const Center(
                  child: CircularProgressIndicator(color: AppColors.primary))
            else if (_doctorsList.isEmpty)
              const Text("No doctors available")
            else
              ..._buildDoctorsList(),
            if (_doctorsList.length > _initialDoctorsCount)
              CustomInkWell(
                onTap: () {
                  setState(() {
                    _showAllDoctors = !_showAllDoctors;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    _showAllDoctors ? "Show Less" : "More",
                    style:
                        TextStyles.regular12.copyWith(color: AppColors.primary),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDoctorsList() {
    // Create doctor asset map for images
    final doctorImages = {
      "ENT Specialist": Assets.doctor1Image,
      "Cardiologist": Assets.doctor2Image,
      "Dermatologist": Assets.doctor3Image,
      "Gastroenterologist": Assets.doctor4Image,
      "Neurologist": Assets.doctor5Image,
      // Add default image for other specializations
    };

    return _displayedDoctors.map((doctor) {
      String imageAsset = doctorImages[doctor["specialization"]] ?? '';

      return CallDoctorTile(
        image: imageAsset != ""
            ? Image.asset(imageAsset)
            : const Padding(
                padding: EdgeInsets.all(AppConstants.borderRadius),
                child: Iconify(
                  Fontisto.doctor,
                ),
              ),
        title: doctor["name"] ?? "Unknown Doctor",
        profession: doctor["specialization"] ?? "Medical Professional",
        contactNumber: doctor['contact_number'] ?? '',
      );
    }).toList();
  }
}
