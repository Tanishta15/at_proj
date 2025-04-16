import 'package:flutter/material.dart';
import 'firestore_service.dart';
import 'book_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestore = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text("Your Books")),
      body: StreamBuilder<List<Book>>(
        stream: firestore.getBooks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final books = snapshot.data!;
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return ListTile(
                title: Text(book.title),
                subtitle: Text('${book.author} - ${book.status}'),
                trailing: Text(book.mood),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example: Add dummy book
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
