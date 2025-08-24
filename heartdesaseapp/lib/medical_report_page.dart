import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // 📌 Tarih formatlamak için eklendi

class MedicalReportPage extends StatefulWidget {
  final int? userId; // ID genellikle int olur

  const MedicalReportPage({super.key, required this.userId});
  @override
  State<MedicalReportPage> createState() => _MedicalReportPageState();
}

class _MedicalReportPageState extends State<MedicalReportPage> {
  List<dynamic> heartData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHeartData();
  }

  Future<void> fetchHeartData() async {
    if (widget.userId == null) return;

    try {
      final response = await http.get(
        Uri.parse(
            'http://100.119.177.30/heart_health_mobil_php/heart_data_api.php?userId=${widget.userId}'),
      );
      if (response.statusCode == 200) {
        setState(() {
          heartData = json.decode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Medical Report",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6D0EB5), Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: heartData.length,
          itemBuilder: (context, index) {
            final item = heartData[index];

            // 📌 Tarihi daha anlaşılır hale getirme
            String formattedDate = "";
            try {
              DateTime createdAt = DateTime.parse(item['created_at']);
              formattedDate =
                  DateFormat("dd MMMM yyyy - HH:mm").format(createdAt);
            } catch (e) {
              formattedDate = item['created_at']; // Parse edilemezse ham değer
            }

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          "Patient Name: ${item['Name']}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.white54, height: 20),
                    buildInfoRow(Icons.cake, "Age", item['Age']),
                    buildInfoRow(Icons.male, "Sex", item['Sex']),
                    buildInfoRow(Icons.favorite, "Chest Pain",
                        item['ChestPainType']),
                    buildInfoRow(Icons.monitor_heart, "Resting BP",
                        item['RestingBP']),
                    buildInfoRow(Icons.bloodtype, "Cholesterol",
                        item['Cholesterol']),
                    buildInfoRow(
                        Icons.local_hospital, "FastingBS", item['FastingBS']),
                    buildInfoRow(
                        Icons.eco, "Resting ECG", item['RestingECG']),
                    buildInfoRow(
                        Icons.directions_run, "Max HR", item['MaxHR']),
                    buildInfoRow(Icons.directions_walk, "Exercise Angina",
                        item['ExerciseAngina']),
                    buildInfoRow(
                        Icons.show_chart, "Oldpeak", item['Oldpeak']),
                    buildInfoRow(
                        Icons.trending_up, "ST Slope", item['ST_Slope']),
                    const SizedBox(height: 10),
                    Text(
                      "Prediction: ${item['Prediction'] == 1 ? "Heart Disease" : "No Heart Disease"}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellowAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Register Date : $formattedDate", // 📌 Kullanıcı dostu format
                      style: const TextStyle(
                          fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 18),
          const SizedBox(width: 8),
          Text(
            "$label: $value",
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
