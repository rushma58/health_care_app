import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/features/diet_plan/diet_plan_list/diet_plan_list_screen.dart';

import '../../../core/utils/app_bars/custom_app_bar.dart';
import 'diet_plan_body.dart';

@RoutePage()
class DietPlanScreen extends StatefulWidget implements AutoRouteWrapper {
  const DietPlanScreen({super.key});

  @override
  State<DietPlanScreen> createState() => _DietPlanScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

class _DietPlanScreenState extends State<DietPlanScreen> {
  bool isLoading = true;
  late bool showList = true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late List<Map<String, dynamic>> dietList = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final User? currentUser = _auth.currentUser;
    CollectionReference dietPlanRef = _firestore
        .collection('users')
        .doc(currentUser?.uid)
        .collection("diet_plans");
    QuerySnapshot snapshot = await dietPlanRef.get();

    setState(() {
      dietList = snapshot.docs
          .map((doc) => {
                'disease_to_tackle': doc['disease_to_tackle'],
                'foods_to_have': doc['foods_to_have'],
                'foods_to_avoid': doc['foods_to_avoid'],
                'weekly_diet': doc['weekly_diet']
              })
          .toList();
    });

    if (dietList.isNotEmpty) {
      setState(() {
        showList = true;
        isLoading = false;
      });
    }
    if (dietList.isEmpty) {
      setState(() {
        showList = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Diet Plan',
        action: showList
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showList = !showList;
                  });
                },
                icon: const Icon(
                  Icons.add,
                  color: AppColors.white,
                ))
            : null,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : showList
                ? DietPlanListScreen(
                    dietList: dietList,
                  )
                : const DietPlanBody(),
      ),
    );
  }
}
