import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/text_styles.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.screenPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle:
                    TextStyles.regular14.copyWith(color: AppColors.border),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.border,
                ),
                fillColor: AppColors.textFieldBg,
              ),
            ),
          ),
          IconButton(
            // onPressed: uploadDiseaseData,
            onPressed: () {},
            icon: const Icon(
              Icons.filter_list_rounded,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void uploadDiseaseData() {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference diseaseRef = db.collection('diseases');

    List<Map<String, dynamic>> diseases = [
      {
        "name": "Typhoid Fever",
        "meaning":
            "Typhoid fever is a bacterial infection caused by Salmonella typhi. It spreads through contaminated food and water, often in areas with poor sanitation. The bacteria enter the bloodstream and affect various organs, leading to prolonged fever and digestive issues.",
        "symptoms":
            "High fever, weakness, abdominal pain, headache, loss of appetite, diarrhea or constipation.",
        "precautions":
            "Drink purified water, eat well-cooked food, wash hands regularly, and get vaccinated if at risk."
      },
      {
        "name": "Dengue Fever",
        "meaning":
            "Dengue fever is a viral infection transmitted by Aedes mosquitoes, especially during monsoon and post-monsoon seasons. It can cause severe flu-like symptoms and, in severe cases, lead to dengue hemorrhagic fever, which can be life-threatening.",
        "symptoms":
            "High fever, severe headache, muscle and joint pain, skin rashes, and bleeding gums or nose in severe cases.",
        "precautions":
            "Use mosquito repellents and nets, wear long-sleeved clothes, and prevent mosquito breeding by removing stagnant water."
      },
      {
        "name": "Malaria",
        "meaning":
            "Malaria is a mosquito-borne disease caused by Plasmodium parasites. It spreads through the bites of infected Anopheles mosquitoes and primarily affects people living in tropical and subtropical regions.",
        "symptoms": "Fever, chills, sweating, headache, nausea, and vomiting.",
        "precautions":
            "Use mosquito nets and repellents, avoid mosquito breeding areas, and take antimalarial medication if traveling to high-risk areas."
      },
      {
        "name": "Cholera",
        "meaning":
            "Cholera is a bacterial infection caused by Vibrio cholerae, which leads to severe diarrhea and dehydration. It spreads through contaminated food and water, especially in areas with inadequate sanitation.",
        "symptoms":
            "Watery diarrhea, vomiting, rapid dehydration, and muscle cramps.",
        "precautions":
            "Drink clean water, eat hygienic food, wash hands regularly, and maintain proper sanitation."
      },
      {
        "name": "Tuberculosis (TB)",
        "meaning":
            "Tuberculosis is a contagious bacterial infection caused by Mycobacterium tuberculosis. It mainly affects the lungs but can also spread to other organs. It is transmitted through airborne droplets when an infected person coughs or sneezes.",
        "symptoms":
            "Chronic cough (sometimes with blood), weight loss, night sweats, fever, and fatigue.",
        "precautions":
            "Cover mouth while coughing or sneezing, get the BCG vaccine, and complete the full course of treatment if diagnosed."
      },
      {
        "name": "Pneumonia",
        "meaning":
            "Pneumonia is an infection that inflames the air sacs in one or both lungs. It can be caused by bacteria, viruses, or fungi and is common in children and elderly individuals. In severe cases, it can cause breathing difficulties and require hospitalization.",
        "symptoms":
            "Fever, cough with phlegm, shortness of breath, chest pain, and fatigue.",
        "precautions":
            "Get vaccinated, maintain hygiene, avoid smoking, and limit exposure to air pollution."
      },
      {
        "name": "Hepatitis A & E",
        "meaning":
            "Hepatitis A and E are viral infections that cause inflammation of the liver. They are primarily spread through contaminated food and water and are common in regions with poor sanitation.",
        "symptoms":
            "Jaundice (yellowing of skin and eyes), fatigue, nausea, abdominal pain, and loss of appetite.",
        "precautions":
            "Avoid consuming unhygienic food and water, maintain personal hygiene, and get vaccinated for Hepatitis A."
      },
      {
        "name": "Diarrheal Diseases",
        "meaning":
            "Diarrheal diseases are caused by bacterial, viral, or parasitic infections leading to frequent and watery stools. It is a leading cause of dehydration, especially in children in developing countries.",
        "symptoms":
            "Loose or watery stools, dehydration, stomach cramps, and nausea.",
        "precautions":
            "Drink safe and purified water, maintain proper hygiene, and eat fresh and properly cooked food."
      },
      {
        "name": "Hypertension (High Blood Pressure)",
        "meaning":
            "Hypertension is a chronic medical condition where the force of the blood against artery walls remains high. It increases the risk of heart disease, stroke, and kidney failure if left unmanaged.",
        "symptoms":
            "Often no symptoms, but can include headaches, dizziness, blurred vision, and chest pain.",
        "precautions":
            "Reduce salt intake, exercise regularly, manage stress, and maintain a healthy weight."
      },
      {
        "name": "Diabetes",
        "meaning":
            "Diabetes is a metabolic disorder characterized by high blood sugar levels due to insulin deficiency or resistance. It can lead to long-term complications like kidney disease, nerve damage, and heart problems if not managed properly.",
        "symptoms":
            "Frequent urination, excessive thirst, fatigue, and slow wound healing.",
        "precautions":
            "Maintain a balanced diet, exercise regularly, monitor blood sugar levels, and follow medical advice."
      }
    ];

    for (var disease in diseases) {
      // databaseRef.push().set(disease);
      diseaseRef.doc().set(disease);
    }
  }
}
