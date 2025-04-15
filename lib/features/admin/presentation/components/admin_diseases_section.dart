import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/text_styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';

class AdminDiseasesSection extends StatefulWidget {
  const AdminDiseasesSection({super.key});

  @override
  State<AdminDiseasesSection> createState() => _AdminDiseasesSectionState();
}

class _AdminDiseasesSectionState extends State<AdminDiseasesSection> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _meaningController = TextEditingController();
  final TextEditingController _symptomsController = TextEditingController();
  final TextEditingController _precautionsController = TextEditingController();
  List<Map<String, dynamic>> _diseases = [];
  bool _isLoading = true;
  bool _isAdding = false;

  @override
  void initState() {
    super.initState();
    _fetchDiseases();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _meaningController.dispose();
    _symptomsController.dispose();
    _precautionsController.dispose();
    super.dispose();
  }

  Future<void> _fetchDiseases() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('diseases').get();
      setState(() {
        _diseases = snapshot.docs.map((doc) {
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
      log("Error fetching diseases: $e");
    }
  }

  Future<void> _addDisease() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a disease name')),
      );
      return;
    }

    setState(() {
      _isAdding = true;
    });

    try {
      await _firestore.collection('diseases').add({
        'name': _nameController.text,
        'meaning': _meaningController.text,
        'symptoms': _symptomsController.text,
        'precautions': _precautionsController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      _nameController.clear();
      _meaningController.clear();
      _symptomsController.clear();
      _precautionsController.clear();

      await _fetchDiseases();
    } catch (e) {
      log("Error adding disease: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add disease')),
      );
    } finally {
      setState(() {
        _isAdding = false;
      });
    }
  }

  Future<void> _deleteDisease(String id) async {
    try {
      await _firestore.collection('diseases').doc(id).delete();
      await _fetchDiseases();
    } catch (e) {
      log("Error deleting disease: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete disease')),
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
            'Diseases Management',
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
                    'Add New Disease',
                    style:
                        TextStyles.semi14.copyWith(color: AppColors.drawerText),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Disease Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _meaningController,
                    decoration: const InputDecoration(
                      labelText: 'Meaning',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _symptomsController,
                    decoration: const InputDecoration(
                      labelText: 'Symptoms',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _precautionsController,
                    decoration: const InputDecoration(
                      labelText: 'Precautions',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isAdding ? null : _addDisease,
                      child: _isAdding
                          ? const CircularProgressIndicator()
                          : const Text('Add Disease'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Diseases List',
            style: TextStyles.semi14.copyWith(color: AppColors.drawerText),
          ),
          const SizedBox(height: 16),
          ..._diseases.map((disease) {
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
                        MaterialSymbols.health_and_safety_outline,
                        color: AppColors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          disease['name'],
                          style: TextStyles.regular14.copyWith(
                            color: AppColors.drawerText,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: AppColors.danger),
                        onPressed: () => _deleteDisease(disease['id']),
                      ),
                    ],
                  ),
                  if (disease['meaning'] != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Meaning:',
                      style: TextStyles.semi12.copyWith(color: AppColors.grey),
                    ),
                    Text(
                      disease['meaning'],
                      style:
                          TextStyles.regular12.copyWith(color: AppColors.grey),
                    ),
                  ],
                  if (disease['symptoms'] != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Symptoms:',
                      style: TextStyles.semi12.copyWith(color: AppColors.grey),
                    ),
                    Text(
                      disease['symptoms'],
                      style:
                          TextStyles.regular12.copyWith(color: AppColors.grey),
                    ),
                  ],
                  if (disease['precautions'] != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Precautions:',
                      style: TextStyles.semi12.copyWith(color: AppColors.grey),
                    ),
                    Text(
                      disease['precautions'],
                      style:
                          TextStyles.regular12.copyWith(color: AppColors.grey),
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
