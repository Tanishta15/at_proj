import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image with Opacity
            Positioned.fill(
              child: Opacity(
                opacity: 0.5, // Adjust opacity here
                child: Image.asset(
                  'assets/Book lover Wallpaper.jpg', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Your Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ListView(
                children: [
                  const Text(
                    'Your stories',
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _bookCard(
                    image: 'assets/book4.jpeg',
                    label: 'Continue\nPart 38',
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Top picks for you',
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 190,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _topPickCard('assets/book1.jpeg', 'Romance'),
                        _topPickCard('assets/book2.jpeg', 'Friendship'),
                        _topPickCard('assets/book3.jpeg', 'Romance'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Top 10 in India',
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: [
                      _top10Card('1', 'assets/book4.jpeg', 'Historical Fiction'),
                      _top10Card('2', 'assets/book5.jpeg', 'Children'),
                      _top10Card('3', 'assets/book1.jpeg', 'Contemporary romance'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bookCard({required String image, required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _topPickCard(String image, String tag) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              tag,
              style: const TextStyle(color: Colors.pinkAccent, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _top10Card(String number, String image, String tag) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  number,
                  style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tag,
              style: const TextStyle(color: Colors.pinkAccent, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}