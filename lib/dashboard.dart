import 'package:flutter/material.dart';
import 'firestore_service.dart';
import 'book_model.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestore = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "📚 Your Bookshelf",
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Book lover Wallpaper.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Book List with Transparent Overlay
          Container(
            color: Colors.white.withOpacity(0.4),
            child: StreamBuilder<List<Book>>(
              stream: firestore.getBooks(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final books = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      color: Colors.white.withOpacity(0.85),
                      child: ListTile(
                        leading: const Icon(Icons.menu_book_rounded, color: Colors.purple, size: 36),
                        title: Text(
                          book.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text("${book.author} • ${book.status}"),
                        trailing: Text(
                          book.mood,
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          firestore.addBook(Book(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: "New Book",
            author: "New Author",
            mood: "lighthearted",
            status: "reading",
            pages: 300,
            year: 2024,
          ));
        },
        child: Lottie.asset(
          'assets/Animation - 1744914550036.json', // 🔄 fixed name here
          width: 45,
          height: 45,
        ),
      ),
    );
  }
}
