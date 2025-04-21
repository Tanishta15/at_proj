import 'package:flutter/material.dart';
import '../genre_section.dart'; // Your existing GenreSection widget

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  final List<String> genres = const [
    "Fantasy",
    "Romance",
    "Mystery",
    "Science Fiction"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: genres.map((genre) {
          return GenreSection(genre: genre);
        }).toList(),
      ),
    );
  }
}
