import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  // Constructor to accept the book data
  final Map<String, dynamic> book;

  const BookDetailsPage({required this.book, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the book cover image
            Center(
              child: Image.network(
                book['coverUrl'] ?? 'https://via.placeholder.com/300', // Default placeholder
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Display the book title
            Text(
              book['title'] ?? 'Unknown Title',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Display the book author
            Text(
              book['author'] ?? 'Unknown Author',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),

            // Display the book description
            Text(
              book['description'] ?? 'No description available.',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}