import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/download.jpg'), // Add your image asset
              backgroundColor: Colors.pink[100],
            ),

            const SizedBox(height: 20),

            // Name
            const Text(
              "Prarthana Prem",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Serif',
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 8),

            // Bio
            const Text(
              "Bookworm 📚 | Dreamer ✨ | Coder 👩‍💻",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            // Edit Profile Button
            ElevatedButton.icon(
              onPressed: () {
                // Add your edit action here
              },
              icon: const Icon(Icons.edit, size: 20),
              label: const Text("Edit Profile"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}