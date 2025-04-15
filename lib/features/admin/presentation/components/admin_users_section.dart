import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/text_styles.dart';

class AdminUsersSection extends StatefulWidget {
  const AdminUsersSection({super.key});

  @override
  State<AdminUsersSection> createState() => _AdminUsersSectionState();
}

class _AdminUsersSectionState extends State<AdminUsersSection> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('users').get();
      setState(() {
        _users = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            'id': doc.id,
            ...data,
          };
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      log("Error fetching users: $e");
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
            'Users List',
            style: TextStyles.bold16.copyWith(color: AppColors.drawerText),
          ),
          const SizedBox(height: 16),
          ..._users.map((user) {
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
                      const Icon(
                        Icons.person,
                        color: AppColors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          user['email'] ?? 'No email',
                          style: TextStyles.regular14.copyWith(
                            color: AppColors.drawerText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        color: AppColors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        user['phone'] ?? 'No phone',
                        style: TextStyles.regular12.copyWith(
                          color: AppColors.grey,
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
                        'Joined: ${user['createdAt']?.toDate().toString().split(' ')[0] ?? 'Unknown'}',
                        style: TextStyles.regular12.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
