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
        title: const Text('M.A.S.L.A',
            style: TextStyle(color: Colors.black, fontSize: 24.0)),
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
            DashboardCard(
              title: 'Coding Quiz',
              color: Colors.redAccent,
              icon: Icons.code,
              onTap: () {},
              isLocked: true, // Lock the card
            ),
            DashboardCard(
              title: 'Maths Understood',
              color: Colors.blueGrey,
              icon: Icons.calculate,
              onTap: () {},
              isLocked: true, // Lock the card
            ),
            DashboardCard(
              title: 'Science Explorer',
              color: Colors.greenAccent,
              icon: Icons.science,
              onTap: () {},
              isLocked: true, // Lock the card
            ),
            DashboardCard(
              title: 'History Buff',
              color: Colors.brown,
              icon: Icons.history,
              onTap: () {},
              isLocked: true, // Lock the card
            ),
            DashboardCard(
              title: 'Geography Guru',
              color: Colors.lightBlueAccent,
              icon: Icons.public,
              onTap: () {},
              isLocked: true, // Lock the card
            ),
            DashboardCard(
              title: 'Art Aficionado',
              color: Colors.pinkAccent,
              icon: Icons.brush,
              onTap: () {},
              isLocked: true, // Lock the card
            ),
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
  final bool isLocked;

  const DashboardCard({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
    required this.onTap,
    this.isLocked = false, // Added to check if the level is locked
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked ? null : onTap, // Disable tap if locked
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: isLocked ? 0.5 : 1.0, // Dim the card if locked
            child: Card(
              color: color,
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 48.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Add a lock icon overlay if the level is locked
          if (isLocked)
            const Positioned(
              child: Icon(
                Icons.lock,
                color: Colors.white,
                size: 48.0,
              ),
            ),
        ],
      ),
    );
  }
}
