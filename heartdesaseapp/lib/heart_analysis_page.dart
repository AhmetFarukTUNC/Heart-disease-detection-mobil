import 'package:flutter/material.dart';
import 'package:heartdesaseapp/medical_report_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HeartAnalysisPage extends StatefulWidget {
  final int? userId; // ID genellikle int olur

  const HeartAnalysisPage({super.key, required this.userId});

  @override
  State<HeartAnalysisPage> createState() => _HeartAnalysisPageState();
}

class _HeartAnalysisPageState extends State<HeartAnalysisPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Yeni eklenen Name kontrolcüsü
  final nameController = TextEditingController();

  // Kontroller
  final ageController = TextEditingController();
  String sex = 'M';
  String chestPain = 'TA';
  final restingBPController = TextEditingController();
  final cholesterolController = TextEditingController();
  final fastingBSController = TextEditingController();
  String restingECG = 'Normal';
  final maxHRController = TextEditingController();
  String exerciseAngina = 'N';
  final oldpeakController = TextEditingController();
  String stSlope = 'Up';

  String result = '';
  bool showResult = false;

  // API URL
  final String apiUrl = "http://10.0.2.2:5000/predict"; // Emulator için

  Future<void> predictHeartDisease() async {
    if (!_formKey.currentState!.validate()) return;

    final features = [
      int.parse(ageController.text),
      sex,
      chestPain,
      int.parse(restingBPController.text),
      int.parse(cholesterolController.text),
      int.parse(fastingBSController.text),
      restingECG,
      int.parse(maxHRController.text),
      exerciseAngina,
      double.parse(oldpeakController.text),
      stSlope,
    ];

    try {
      // 1) Flask API'ye gönder
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"features": features}),
      );

      final data = jsonDecode(response.body);

      if (data.containsKey("prediction")) {
        setState(() {
          result = data["prediction"] == 1
              ? "High risk of heart disease ❤️"
              : "Low risk of heart disease 💚";
          showResult = true;
        });

        // 2) PHP backend'e kaydet
        await saveToDatabase(features, data["prediction"]);

      } else {
        setState(() {
          result = "Error: ${data['error']}";
          showResult = true;
        });
      }
    } catch (e) {
      setState(() {
        result = "Connection error: $e";
        showResult = true;
      });
    }
  }

  // PHP backend kaydı
  Future<void> saveToDatabase(List features, int prediction) async {
    final phpUrl = "http://100.119.177.30/heart_health_mobil_php/save_heart_data.php";

    final body = {
      "userId": widget.userId.toString(),
      "Name": nameController.text, // Kullanıcıdan alınan isim
      "Age": features[0].toString(),
      "Sex": features[1],
      "ChestPainType": features[2],
      "RestingBP": features[3].toString(),
      "Cholesterol": features[4].toString(),
      "FastingBS": features[5].toString(),
      "RestingECG": features[6],
      "MaxHR": features[7].toString(),
      "ExerciseAngina": features[8],
      "Oldpeak": features[9].toString(),
      "ST_Slope": features[10],
      "Prediction": prediction.toString(),
    };

    try {
      await http.post(
        Uri.parse(phpUrl),
        body: body,
      );
    } catch (e) {
      print("PHP database error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D0EB5), Color(0xFF4059F1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Başlık ve ikon
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Colors.pinkAccent, Colors.orangeAccent],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orangeAccent.withOpacity(0.5),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.monitor_heart,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Heart Disease Prediction",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Form alanları
                  buildTextField(nameController, "Name", TextInputType.text),
                  buildTextField(ageController, "Age", TextInputType.number),
                  buildDropdown("Sex", sex, ['M', 'F'], (val) => sex = val!),
                  buildDropdown("Chest Pain Type", chestPain, ['TA','ATA','NAP','ASY'], (val) => chestPain = val!),
                  buildTextField(restingBPController, "Resting BP", TextInputType.number),
                  buildTextField(cholesterolController, "Cholesterol", TextInputType.number),
                  buildTextField(fastingBSController, "Fasting BS", TextInputType.number),
                  buildDropdown("Resting ECG", restingECG, ['Normal','ST','LVH'], (val) => restingECG = val!),
                  buildTextField(maxHRController, "Max HR", TextInputType.number),
                  buildDropdown("Exercise Angina", exerciseAngina, ['Y','N'], (val) => exerciseAngina = val!),
                  buildTextField(oldpeakController, "Oldpeak", TextInputType.number),
                  buildDropdown("ST Slope", stSlope, ['Up','Flat','Down'], (val) => stSlope = val!),

                  const SizedBox(height: 24),

                  // Gradient Predict buton
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.pinkAccent, Colors.orangeAccent],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pinkAccent.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: predictHeartDisease,
                        borderRadius: BorderRadius.circular(16),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: Text(
                              "Predict",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Sonuç kutusu
                  if (showResult)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: result.contains("High")
                            ? const LinearGradient(colors: [Colors.redAccent, Colors.orangeAccent])
                            : const LinearGradient(colors: [Colors.green, Colors.lightGreenAccent]),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          result,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 12),

                  // Alt butonlar
                  buildNavigationButton("Go to Medical Report", [Colors.blueAccent, Colors.lightBlueAccent], () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MedicalReportPage(userId: widget.userId)),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Input alanı builder
  Widget buildTextField(TextEditingController controller, String label, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
          hintText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) => value!.isEmpty ? "Required" : null,
      ),
    );
  }

  // Dropdown builder
  Widget buildDropdown(String label, String currentValue, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: currentValue,
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Navigation buton builder
  Widget buildNavigationButton(String text, List<Color> gradientColors, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradientColors),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
