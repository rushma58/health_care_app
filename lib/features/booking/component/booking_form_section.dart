import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/utils/inputs/custom_date_input.dart';
import 'package:health_care_app/core/utils/inputs/custom_searchable_dropdown.dart';

import '../../../core/constants/app_spaces.dart';
import '../../../core/helpers/validation_helper.dart';
import '../../../core/utils/inputs/custom_input.dart';

class BookingFormSection extends StatefulWidget {
  final TextEditingController date;
  final TextEditingController doctor;
  final TextEditingController symptoms;

  const BookingFormSection({
    super.key,
    required this.date,
    required this.doctor,
    required this.symptoms,
  });

  @override
  State<BookingFormSection> createState() => _BookingFormSectionState();
}

class _BookingFormSectionState extends State<BookingFormSection> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _doctorsList = [];
  List<Map<String, dynamic>> _filteredDoctorsList = [];
  bool _isLoading = true;

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
            .map((doc) => {
                  'id': doc.id,
                  'name': doc['name'],
                  'specialization': doc['specialization'],
                })
            .toList();
        _filteredDoctorsList = _doctorsList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterDoctors(String query) {
    setState(() {
      _filteredDoctorsList = _doctorsList
          .where((doctor) =>
              doctor['name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              doctor['specialization']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  String? _validateDoctor(dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return 'Doctor Cannot Be Empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : Column(
            children: [
              CustomDateInput(
                hint: 'Enter Date',
                label: 'Date',
                controller: widget.date,
                showPastAndHideFuture: false,
              ),
              AppSpaces.medium,
              CustomSearchableDropdown<String>(
                label: 'Doctor',
                hint: 'Select Doctor',
                items: _filteredDoctorsList.map((doctor) {
                  return DropdownMenuItem<String>(
                    value: doctor['id'],
                    child:
                        Text('${doctor['name']} - ${doctor['specialization']}'),
                  );
                }).toList(),
                value: widget.doctor.text.isEmpty ? null : widget.doctor.text,
                onChanged: (value) {
                  if (value != null) {
                    widget.doctor.text = value;
                  }
                },
                onSearchChanged: _filterDoctors,
                validator: _validateDoctor,
              ),
              AppSpaces.medium,
              CustomInput(
                label: 'Symptoms',
                hint: 'Enter Symptoms',
                controller: widget.symptoms,
                textInputType: TextInputType.multiline,
                validator: (value) =>
                    ValidationHelper.checkEmptyField(value, field: 'symptoms'),
              ),
            ],
          );
  }
}
