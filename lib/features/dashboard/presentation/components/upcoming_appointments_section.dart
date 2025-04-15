import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/text_styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:iconify_flutter/icons/vaadin.dart';

class UpcomingAppointmentsSection extends StatefulWidget {
  const UpcomingAppointmentsSection({super.key});

  @override
  State<UpcomingAppointmentsSection> createState() =>
      _UpcomingAppointmentsSectionState();
}

class _UpcomingAppointmentsSectionState
    extends State<UpcomingAppointmentsSection> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> _appointments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUpcomingAppointments();
  }

  Future<void> _fetchUpcomingAppointments() async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        final QuerySnapshot snapshot = await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .collection('appointments')
            .where('status', isEqualTo: 'pending')
            .orderBy('date')
            .get();

        List<Map<String, dynamic>> appointments = [];

        for (var doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;

          // Fetch doctor details
          if (data['doctor'] != null) {
            final doctorDoc = await _firestore
                .collection('doctors')
                .doc(data['doctor'])
                .get();

            if (doctorDoc.exists) {
              final doctorData = doctorDoc.data() as Map<String, dynamic>;
              appointments.add({
                'id': doc.id,
                ...data,
                'doctorName': '${doctorData['name']}',
                'doctorSpecialization': doctorData['specialization'] ?? '',
              });
            } else {
              appointments.add({
                'id': doc.id,
                ...data,
                'doctorName': 'Unknown Doctor',
                'doctorSpecialization': '',
              });
            }
          } else {
            appointments.add({
              'id': doc.id,
              ...data,
              'doctorName': 'Unknown Doctor',
              'doctorSpecialization': '',
            });
          }
        }

        setState(() {
          _appointments = appointments;
          _isLoading = false;
        });

        log(">>>>>>>>>>>>>>>>> $_appointments");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      log("Error fetching appointments: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_appointments.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            const Iconify(
              Healthicons.health_worker,
              color: AppColors.primary,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No Upcoming Appointments',
                    style: TextStyles.semi14.copyWith(color: AppColors.primary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Book an appointment to get started',
                    style: TextStyles.regular12.copyWith(color: AppColors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Upcoming Appointments',
            style: TextStyles.bold16.copyWith(color: AppColors.drawerText),
          ),
        ),
        ..._appointments.map((appointment) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getAppointmentColor(appointment['date']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              border: Border.all(
                color:
                    _getAppointmentColor(appointment['date']).withOpacity(0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: _getAppointmentColor(appointment['date']),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      appointment['date'],
                      style: TextStyles.semi14.copyWith(
                        color: _getAppointmentColor(appointment['date']),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getAppointmentColor(appointment['date'])
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getAppointmentStatus(appointment['date']),
                        style: TextStyles.regular12.copyWith(
                          color: _getAppointmentColor(appointment['date']),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Iconify(
                      Vaadin.doctor,
                      color: AppColors.grey,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment['doctorName'],
                            style: TextStyles.regular14.copyWith(
                              color: AppColors.drawerText,
                            ),
                          ),
                          if (appointment['doctorSpecialization'] != null &&
                              appointment['doctorSpecialization'].isNotEmpty)
                            Text(
                              appointment['doctorSpecialization'],
                              style: TextStyles.regular12.copyWith(
                                color: AppColors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (appointment['symptoms'] != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.medical_services,
                        color: AppColors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          appointment['symptoms'],
                          style: TextStyles.regular12.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        }),
      ],
    );
  }

  Color _getAppointmentColor(String date) {
    final appointmentDate = DateTime.parse(date);
    final now = DateTime.now();

    // Normalize dates to remove time component for accurate day comparison
    final normalizedAppointmentDate = DateTime(
        appointmentDate.year, appointmentDate.month, appointmentDate.day);
    final normalizedNow = DateTime(now.year, now.month, now.day);

    final difference =
        normalizedAppointmentDate.difference(normalizedNow).inDays;

    if (difference < 0) {
      return AppColors.danger; // Past appointment
    } else if (difference == 0) {
      return AppColors.orange; // Today's appointment
    } else if (difference == 1) {
      return AppColors.warning; // Tomorrow's appointment
    } else {
      return AppColors.primary; // Future appointment (2+ days away)
    }
  }

  String _getAppointmentStatus(String date) {
    final appointmentDate = DateTime.parse(date);
    final now = DateTime.now();

    // Normalize dates to remove time component for accurate day comparison
    final normalizedAppointmentDate = DateTime(
        appointmentDate.year, appointmentDate.month, appointmentDate.day);
    final normalizedNow = DateTime(now.year, now.month, now.day);

    final difference =
        normalizedAppointmentDate.difference(normalizedNow).inDays;

    if (difference < 0) {
      return 'Overdue'; // Past appointment
    } else if (difference == 0) {
      return 'Today'; // Today's appointment
    } else if (difference == 1) {
      return 'Tomorrow'; // Tomorrow's appointment
    } else {
      return 'Upcoming'; // Future appointment (2+ days away)
    }
  }
}
