import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'book_details_page.dart'; // Import BookDetailsPage

class GenreSection extends StatelessWidget {
  const GenreSection({
    required this.genre,
    Key? key,
  }) : super(key: key);

  final String genre;

  Stream<QuerySnapshot> getBooksStream() {
    return FirebaseFirestore.instance
        .collection('books')
        .where('genre', isEqualTo: genre)
        .limit(5) // Fetch only 5 books per genre
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          genre,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Georgia',
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        StreamBuilder<QuerySnapshot>(
          stream: getBooksStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Text("Error fetching books: ${snapshot.error}");
            }

            final books = snapshot.data?.docs ?? [];

            if (books.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "No books available for this genre.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
            }

            return SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  final coverUrl = book['coverUrl'] as String?;

                  // Handle missing coverUrl
                  final imageUrl = coverUrl ?? 'https://via.placeholder.com/150'; // Default placeholder

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailsPage(book: book.data() as Map<String, dynamic>),
                        ),
                      );
                    },
                    child: Container(
                      width: 80,
                      height: 120,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white.withOpacity(0.8),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Opacity(
                          opacity: 0.8,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.5),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              book['title'] ?? 'Unknown Title',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}