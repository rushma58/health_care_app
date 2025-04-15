import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/text_styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/vaadin.dart';

class AdminDoctorsSection extends StatefulWidget {
  const AdminDoctorsSection({super.key});

  @override
  State<AdminDoctorsSection> createState() => _AdminDoctorsSectionState();
}

class _AdminDoctorsSectionState extends State<AdminDoctorsSection> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  List<Map<String, dynamic>> _doctors = [];
  bool _isLoading = true;
  bool _isAdding = false;
  bool _isEditing = false;
  String? _editingDoctorId;

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _specializationController.dispose();
    _experienceController.dispose();
    _qualificationController.dispose();
    super.dispose();
  }

  Future<void> _fetchDoctors() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('doctors').get();
      setState(() {
        _doctors = snapshot.docs.map((doc) {
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
      log("Error fetching doctors: $e");
    }
  }

  void _startEditing(Map<String, dynamic> doctor) {
    setState(() {
      _isEditing = true;
      _editingDoctorId = doctor['id'];
      _nameController.text = doctor['name'] ?? '';
      _specializationController.text = doctor['specialization'] ?? '';
      _experienceController.text = doctor['experience'] ?? '';
      _qualificationController.text = doctor['qualification'] ?? '';
    });
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
      _editingDoctorId = null;
      _nameController.clear();
      _specializationController.clear();
      _experienceController.clear();
      _qualificationController.clear();
    });
  }

  Future<void> _addOrUpdateDoctor() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a doctor name')),
      );
      return;
    }

    setState(() {
      _isAdding = true;
    });

    try {
      final doctorData = {
        'name': _nameController.text,
        'specialization': _specializationController.text,
        'experience': _experienceController.text,
        'qualification': _qualificationController.text,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (_isEditing && _editingDoctorId != null) {
        await _firestore
            .collection('doctors')
            .doc(_editingDoctorId)
            .update(doctorData);
      } else {
        await _firestore.collection('doctors').add({
          ...doctorData,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      _nameController.clear();
      _specializationController.clear();
      _experienceController.clear();
      _qualificationController.clear();

      await _fetchDoctors();
      _cancelEditing();
    } catch (e) {
      log("Error ${_isEditing ? 'updating' : 'adding'} doctor: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to ${_isEditing ? 'update' : 'add'} doctor')),
      );
    } finally {
      setState(() {
        _isAdding = false;
      });
    }
  }

  Future<void> _deleteDoctor(String id) async {
    try {
      await _firestore.collection('doctors').doc(id).delete();
      await _fetchDoctors();
    } catch (e) {
      log("Error deleting doctor: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete doctor')),
      );
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
            'Doctors Management',
            style: TextStyles.bold16.copyWith(color: AppColors.drawerText),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isEditing ? 'Edit Doctor' : 'Add New Doctor',
                    style:
                        TextStyles.semi14.copyWith(color: AppColors.drawerText),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Doctor Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _specializationController,
                    decoration: const InputDecoration(
                      labelText: 'Specialization',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _experienceController,
                    decoration: const InputDecoration(
                      labelText: 'Experience',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _qualificationController,
                    decoration: const InputDecoration(
                      labelText: 'Qualification',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isAdding ? null : _addOrUpdateDoctor,
                          child: _isAdding
                              ? const CircularProgressIndicator()
                              : Text(
                                  _isEditing ? 'Update Doctor' : 'Add Doctor'),
                        ),
                      ),
                      if (_isEditing) ...[
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _cancelEditing,
                            child: const Text('Cancel'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Doctors List',
            style: TextStyles.semi14.copyWith(color: AppColors.drawerText),
          ),
          const SizedBox(height: 16),
          ..._doctors.map((doctor) {
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
                        child: Text(
                          doctor['name'],
                          style: TextStyles.regular14.copyWith(
                            color: AppColors.drawerText,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: AppColors.primary),
                        onPressed: () => _startEditing(doctor),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: AppColors.danger),
                        onPressed: () => _deleteDoctor(doctor['id']),
                      ),
                    ],
                  ),
                  if (doctor['specialization'] != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.medical_services,
                          color: AppColors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          doctor['specialization'],
                          style: TextStyles.regular12.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (doctor['experience'] != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.work,
                          color: AppColors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${doctor['experience']} years of experience',
                          style: TextStyles.regular12.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (doctor['qualification'] != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.school,
                          color: AppColors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          doctor['qualification'],
                          style: TextStyles.regular12.copyWith(
                            color: AppColors.grey,
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
}
