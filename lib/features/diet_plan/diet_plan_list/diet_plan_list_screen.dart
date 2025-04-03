import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/text_styles.dart';

import '../../../config/routes/app_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spaces.dart';

@RoutePage()
class DietPlanListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> dietList;
  const DietPlanListScreen({
    super.key,
    required this.dietList,
  });

  @override
  State<DietPlanListScreen> createState() => _DietPlanListScreenState();
}

class _DietPlanListScreenState extends State<DietPlanListScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.dietList.length,
      itemBuilder: (context, index) {
        var data = widget.dietList[index];
        String diseaseName = data['disease_to_tackle'] ?? 'General Diet Plan';
        String timestamp = '';

        if (data['timestamp'] != null) {
          Timestamp ts = data['timestamp'] as Timestamp;
          DateTime dateTime = ts.toDate();
          timestamp = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
        }

        return DietPlanCard(
          diseaseName: diseaseName,
          timestamp: timestamp,
          onTap: () {
            // Navigate to diet plan details
            AutoRouter.of(context).push(
              DietResponseRoute(
                dietResponse: data,
              ),
            );
          },
        );
      },
    );
  }
}

class DietPlanCard extends StatelessWidget {
  final String diseaseName;
  final String timestamp;
  final VoidCallback onTap;

  const DietPlanCard({
    super.key,
    required this.diseaseName,
    required this.timestamp,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      diseaseName,
                      style: TextStyles.bold18,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.grey,
                  ),
                ],
              ),
              if (timestamp.isNotEmpty) ...[
                AppSpaces.small,
                Text(
                  'Created: $timestamp',
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
