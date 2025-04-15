import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/routes/app_routes.dart';
import '../../core/constants/app_colors.dart';
import '../auth/service/auth/auth_bloc.dart';
import '../auth/service/auth/auth_event.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  @override
  void initState() {
    super.initState();
    _checkUserAndRedirect(context);
    // _auth.authStateChanges().listen((event) {
    //   setState(() {
    //     _user = event;
    //   });
    // });
    Timer(const Duration(seconds: 1), () => _handleChanges(context));
  }

  Future<void> _checkUserAndRedirect(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userUid = prefs.getString('user');
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final CollectionReference users = db.collection('users');

      if (userUid != null) {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null || user?.uid != '') {
          final DocumentSnapshot userDoc = await users.doc(user?.uid).get();
          final userData = userDoc.data() as Map<String, dynamic>;

          if (context.mounted) {
            context
                .read<AuthBloc>()
                .add(AuthUserChanged(user, userData: userData));

            if (userData['email'] == 'admin@test.com') {
              context.router.replaceNamed(AppRoutes.admin);
            } else {
              context.router.replaceNamed(AppRoutes.dashboard);
            }
          }
        }
        if (user == null) {
          if (context.mounted) {
            context.router.replaceNamed(AppRoutes.login);
          }
        }
      }
    } catch (e) {
      print("Error in _checkUserAndRedirect: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Center(
        child: Icon(
          Icons.health_and_safety,
          color: AppColors.danger,
          size: 400,
        ),
      ),
    );
  }

  void _handleChanges(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      if (context.mounted) {
        context.router.replaceNamed(AppRoutes.login);
      }
    });
  }
}
