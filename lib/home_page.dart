import 'package:flutter/material.dart';
import 'package:voice_control_race_game/common_quiz_page.dart';
import 'package:voice_control_race_game/music_lessor_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background for Gen Z vibes
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.tealAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            DashboardCard(
              title: 'Music Lessor',
              color: Colors.purpleAccent,
              icon: Icons.music_note,
              onTap: () {
                // Navigate to Music Lessor page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MusicLessorPage()));
              },
            ),
            DashboardCard(
                title: 'Innovation Quiz',
                color: Colors.orangeAccent,
                icon: Icons.question_answer,
                onTap: () {
                  // Open the Innovation Quiz in a web browser
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CommonQuizPage()));
                }),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardCard({
    required this.title,
    required this.color,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50.0, color: Colors.white),
            const SizedBox(height: 10.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
