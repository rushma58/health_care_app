import 'dart:convert';

import 'package:flutter/material.dart';

class DietResponseScreen extends StatefulWidget {
  const DietResponseScreen({super.key});

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
    // In a real app, you would load this from an asset or API
    const String jsonData = '''{
        "foods_to_have": [
          {
            "food": "Broth-based soups",
            "reason": "Provides hydration and electrolytes, soothing for a sore throat."
          },
          {
            "food": "Ginger",
            "reason": "Has anti-inflammatory properties, can help soothe a cough."
          },
          {
            "food": "Garlic",
            "reason": "Natural antibiotic properties, can help fight infection."
          },
          {
            "food": "Honey",
            "reason": "Soothes a sore throat and cough."
          },
          {
            "food": "Lemon",
            "reason": "Rich in Vitamin C, boosts immunity."
          },
          {
            "food": "Chicken soup (vegetarian broth alternative available)",
            "reason": "Easy to digest, provides hydration and nutrients."
          },
          {
            "food": "Fruits (berries, bananas, applesauce)",
            "reason": "Rich in vitamins and antioxidants, supports the immune system.  Easy to digest when sick."
          },
          {
            "food": "Vegetables (steamed or cooked, easily digestible)",
            "reason": "Provide essential vitamins and minerals."
          },
          {
            "food": "Plain yogurt",
            "reason": "Good source of probiotics, aids digestion."
          },
          {
            "food": "Warm liquids (herbal tea, water)",
            "reason": "Helps to keep hydrated and soothe a sore throat."
          }
        ],
        "foods_to_avoid": [
          {
            "food": "Spicy foods",
            "reason": "Can irritate the throat and worsen cough."
          },
          {
            "food": "Fried foods",
            "reason": "Difficult to digest, can upset the stomach."
          },
          {
            "food": "Sugary drinks and foods",
            "reason": "Can weaken the immune system and worsen congestion."
          },
          {
            "food": "Dairy products (if causing congestion)",
            "reason": "Can increase mucus production in some individuals."
          },
          {
            "food": "Processed foods",
            "reason": "Lack essential nutrients and can be difficult to digest."
          },
          {
            "food": "Alcohol and caffeine",
            "reason": "Can dehydrate the body."
          },
          {
            "food": "Heavy, greasy foods",
            "reason": "Difficult to digest when sick."
          }
        ],
        "weekly_diet": [
          {
            "day": "Monday",
            "breakfast": "Oatmeal with berries and honey",
            "lunch": "Vegetable soup and whole-wheat toast",
            "dinner": "Steamed vegetables with brown rice"
          },
          {
            "day": "Tuesday",
            "breakfast": "Scrambled eggs (if tolerated) with whole-wheat toast",
            "lunch": "Lentil soup",
            "dinner": "Chicken soup (vegetarian broth alternative) with quinoa"
          },
          {
            "day": "Wednesday",
            "breakfast": "Plain yogurt with banana slices",
            "lunch": "Salad with grilled vegetables and lemon vinaigrette",
            "dinner": "Baked sweet potato with black beans"
          },
          {
            "day": "Thursday",
            "breakfast": "Oatmeal with applesauce",
            "lunch": "Vegetable curry with brown rice",
            "dinner": "Steamed broccoli and chickpeas"
          },
          {
            "day": "Friday",
            "breakfast": "Smoothie with fruits and vegetables",
            "lunch": "Leftover vegetable curry",
            "dinner": "Pasta with marinara sauce and vegetables"
          },
          {
            "day": "Saturday",
            "breakfast": "Whole-wheat toast with avocado",
            "lunch": "Salad with chickpeas and grilled vegetables",
            "dinner": "Vegetable stir-fry"
          },
          {
            "day": "Sunday",
            "breakfast": "Pancakes (whole wheat) with fruit",
            "lunch": "Leftover vegetable stir-fry",
            "dinner": "Lentil stew"
          }
        ]
      }''';

    setState(() {
      dietData = json.decode(jsonData);
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
