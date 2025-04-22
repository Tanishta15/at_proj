import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StatsTab extends StatelessWidget {
  const StatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📅 Date & Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today • Apr 22",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                Icon(Icons.calendar_today, color: Colors.white70),
              ],
            ),
            const SizedBox(height: 20),

            // 🌀 Circular Progress
            Center(
              child: CircularPercentIndicator(
                radius: 90.0,
                lineWidth: 15.0,
                percent: 0.64,
                animation: true,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("640", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                    Text("Pages Read", style: TextStyle(color: Colors.white70)),
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.pinkAccent,
                backgroundColor: Colors.grey[800]!,
              ),
            ),
            const SizedBox(height: 20),

            // 🗓️ Tag Buttons
            Row(
              children: [
                _buildTag("Today's"),
                const SizedBox(width: 10),
                _buildTag("This week", color: Colors.orangeAccent),
                const SizedBox(width: 10),
                _buildTag("All-time", color: Colors.tealAccent),
              ],
            ),
            const SizedBox(height: 30),

            // 📚 Daily Plan Cards
            Text("Reading Plans", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildPlanCard("Read 30 pages", "Harry Potter", "assets/book1.png", Colors.purpleAccent),
                  _buildPlanCard("Finish Chapter 4", "Atomic Habits", "assets/book2.png", Colors.deepOrangeAccent),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 🌐 Community Section
            Text("Community", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildCommunityCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, {Color color = Colors.pinkAccent}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildPlanCard(String title, String subtitle, String imgPath, Color color) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(subtitle, style: TextStyle(color: Colors.white70)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.bookmark, color: Colors.white),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow, color: Colors.black),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCommunityCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset("assets/community.png", width: 80, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Join the Reader’s Club", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text("Share reviews and track group reads", style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
