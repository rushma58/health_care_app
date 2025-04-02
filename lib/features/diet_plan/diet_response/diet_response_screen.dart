import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DietResponseScreen extends StatefulWidget {
  final Map<String, dynamic> dietResponse;
  const DietResponseScreen({
    super.key,
    required this.dietResponse,
  });

  @override
  _DietResponseScreenState createState() => _DietResponseScreenState();
}

class _DietResponseScreenState extends State<DietResponseScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, dynamic> dietData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    loadDietData();
  }

  void loadDietData() async {
    setState(() {
      dietData = widget.dietResponse;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthy Diet Plan'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Weekly Plan', icon: Icon(Icons.calendar_today)),
            Tab(text: 'Foods to Have', icon: Icon(Icons.check_circle)),
            Tab(text: 'Foods to Avoid', icon: Icon(Icons.cancel)),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildWeeklyPlan(),
                _buildFoodsList(
                    dietData['foods_to_have'], Colors.green.shade50),
                _buildFoodsList(dietData['foods_to_avoid'], Colors.red.shade50),
              ],
            ),
    );
  }

  Widget _buildWeeklyPlan() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dietData['weekly_diet'].length,
      itemBuilder: (context, index) {
        final day = dietData['weekly_diet'][index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            title: Text(
              day['day'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            children: [
              _buildMealTile('Breakfast', day['breakfast'], Icons.wb_sunny),
              const Divider(height: 1),
              _buildMealTile('Lunch', day['lunch'], Icons.cloud),
              const Divider(height: 1),
              _buildMealTile('Dinner', day['dinner'], Icons.nights_stay),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMealTile(String mealType, String meal, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title:
          Text(mealType, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(meal),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    );
  }

  Widget _buildFoodsList(List<dynamic> foods, Color backgroundColor) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: foods.length,
      itemBuilder: (context, index) {
        final food = foods[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 16),
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food['food'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  food['reason'],
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
