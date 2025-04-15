import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/text_styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/vaadin.dart';

class AdminAppointmentsSection extends StatefulWidget {
  const AdminAppointmentsSection({super.key});

  @override
  State<AdminAppointmentsSection> createState() =>
      _AdminAppointmentsSectionState();
}

class _AdminAppointmentsSectionState extends State<AdminAppointmentsSection> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _appointments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('appointment_history')
          .orderBy('date', descending: true)
          .get();

      List<Map<String, dynamic>> appointments = [];

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;

        // Fetch doctor details
        if (data['doctor'] != null) {
          final doctorDoc =
              await _firestore.collection('doctors').doc(data['doctor']).get();

          if (doctorDoc.exists) {
            final doctorData = doctorDoc.data() as Map<String, dynamic>;
            appointments.add({
              'id': doc.id,
              ...data,
              'doctorName': doctorData['name'],
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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appointments History',
            style: TextStyles.bold16.copyWith(color: AppColors.drawerText),
          ),
          const SizedBox(height: 16),
          ..._appointments.map((appointment) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: AppColors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          appointment['userEmail'] ?? 'Unknown User',
                          style: TextStyles.regular12.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: AppColors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        appointment['date'],
                        style: TextStyles.regular12.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      const Spacer(),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 8,
                      //     vertical: 4,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: _getStatusColor(appointment['status'])
                      //         .withOpacity(0.2),
                      //     borderRadius: BorderRadius.circular(12),
                      //   ),
                      //   child: Text(
                      //     appointment['status'] ?? 'Unknown',
                      //     style: TextStyles.regular12.copyWith(
                      //       color: _getStatusColor(appointment['status']),
                      //     ),
                      //   ),
                      // ),
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
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
        return AppColors.success;
      case 'cancelled':
        return AppColors.danger;
      case 'pending':
        return AppColors.warning;
      default:
        return AppColors.grey;
    }
  }
}
