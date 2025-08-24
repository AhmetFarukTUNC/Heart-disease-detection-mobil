import 'package:flutter/material.dart';
import 'heart_analysis_page.dart';
import 'medical_report_page.dart';

class HomePage extends StatelessWidget {
  final int? userId; // ID genellikle int olur

  const HomePage({super.key, required this.userId});

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 20),
              // userId yazdırılıyor

              const Text(
                "Heart Disease Dashboard",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50),
              GradientButton(
                text: "Heart Analysis",
                icon: Icons.monitor_heart,
                gradient: const LinearGradient(
                  colors: [Colors.pinkAccent, Colors.redAccent],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HeartAnalysisPage(userId: userId)),
                  );
                },
              ),
              const SizedBox(height: 30),
              GradientButton(
                text: "Medical Report",
                icon: Icons.file_present,
                gradient: const LinearGradient(
                  colors: [Colors.orangeAccent, Colors.yellowAccent],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MedicalReportPage(userId:userId)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onPressed;

  const GradientButton({
    super.key,
    required this.text,
    required this.icon,
    required this.gradient,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
