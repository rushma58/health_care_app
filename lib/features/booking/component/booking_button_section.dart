import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/utils/toasts/custom_toasts.dart';

import '../../../../../../core/constants/app_spaces.dart';
import '../../../../../../core/utils/buttons/expanded_filled_button.dart';

class BookingButtonSection extends StatefulWidget {
  final TextEditingController date;
  final TextEditingController doctor;
  final TextEditingController symptoms;
  const BookingButtonSection({
    super.key,
    required this.date,
    required this.doctor,
    required this.symptoms,
  });

  @override
  State<BookingButtonSection> createState() => _BookingButtonSectionState();
}

class _BookingButtonSectionState extends State<BookingButtonSection> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpaces.veryLarge,
        ExpandedFilledButton(
          isLoading: false,
          backgroundColor: AppColors.primary,
          title: 'Book An Appointment',
          onTap: () {
            if (Form.of(context).validate()) {
              final appointmentData = {
                'doctor': widget.doctor.text,
                'date': widget.date.text,
                'symptoms': widget.symptoms.text,
              };
              _storeData(appointmentData);
            }

            CustomToasts.success("Thank You");
          },
        ),
      ],
    );
  }

  Future<void> _storeData(Map<String, dynamic> appointment) async {
    try {
      // Get current user
      final User? currentUser = auth.currentUser;

      if (currentUser != null) {
        // Add timestamp and user info to the data
        appointment['timestamp'] = FieldValue.serverTimestamp();
        appointment['userId'] = currentUser.uid;

        // Store in Firestore under user's collection
        await firestore
            .collection('users')
            .doc(currentUser.uid)
            .collection('appointments')
            .add(appointment);

        log('Appointment stored successfully in Firebase');
      } else {
        log('Error: No user is currently signed in');
      }
    } catch (e) {
      log('Error storing Appointment in Firebase: $e');
    }
  }
}
