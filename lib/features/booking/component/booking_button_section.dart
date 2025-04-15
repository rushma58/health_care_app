import 'dart:developer';

import 'package:auto_route/auto_route.dart';
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
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpaces.veryLarge,
        ExpandedFilledButton(
          isLoading: _isLoading,
          backgroundColor: AppColors.primary,
          title: 'Book An Appointment',
          onTap: () async {
            if (Form.of(context).validate()) {
              setState(() {
                _isLoading = true;
              });

              final appointmentData = {
                'doctor': widget.doctor.text,
                'date': widget.date.text,
                'symptoms': widget.symptoms.text,
                'createdAt': FieldValue.serverTimestamp(),
                'status': 'pending',
              };

              try {
                await _storeData(appointmentData);
                CustomToasts.success("Appointment Booked Successfully");
                AutoRouter.of(context).maybePop();
              } catch (e) {
                CustomToasts.failure("Failed to book appointment");
              } finally {
                setState(() {
                  _isLoading = false;
                });
              }
            }
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
        // Add user info to the data
        appointment['userId'] = currentUser.uid;
        appointment['userEmail'] = currentUser.email;

        // Store in Firestore under user's collection
        final userAppointmentRef = await firestore
            .collection('users')
            .doc(currentUser.uid)
            .collection('appointments')
            .add(appointment);

        // Store in appointment_history collection
        await firestore.collection('appointment_history').add({
          ...appointment,
          'userAppointmentId': userAppointmentRef.id,
        });

        log('Appointment stored successfully in Firebase');
      } else {
        log('Error: No user is currently signed in');
        throw Exception('No user is currently signed in');
      }
    } catch (e) {
      log('Error storing Appointment in Firebase: $e');
      rethrow;
    }
  }
}
