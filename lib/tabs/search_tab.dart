import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String query = "";
  final List<String> books = [
    "The Midnight Library",
    "Atomic Habits",
    "Pride and Prejudice",
    "The Alchemist",
    "The Book Thief",
    "To Kill a Mockingbird",
    "The Great Gatsby",
    "1984",
  ];

  @override
  Widget build(BuildContext context) {
    final filteredBooks = books
        .where((book) => book.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "🔍 Find Your Next Read",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Serif',
            ),
          ),
          const SizedBox(height: 20),

          // Search Field
          TextField(
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
            decoration: InputDecoration(
              hintText: "Search for books...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.pink[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Search Results
          Expanded(
            child: filteredBooks.isEmpty
                ? const Center(
              child: Text(
                "No books found 🥲",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
                : ListView.builder(
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.pink[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.book, color: Colors.pink),
                    title: Text(
                      filteredBooks[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      // You can later navigate to a book detail page
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}