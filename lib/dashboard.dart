import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _bookTitleController = TextEditingController();

  Future<void> _addBook() async {
    if (_bookTitleController.text.isEmpty) return;

    String userId = _auth.currentUser!.uid;
    await _firestore.collection('books').add({
      'userId': userId,
      'title': _bookTitleController.text.trim(),
      'progress': 0, // Initially unread
      'rating': 0,
      'review': '',
      'username': _auth.currentUser!.email, // Storing for easier lookup
    });

    _bookTitleController.clear();
  }

  Future<void> _updateBook(String docId, int progress, double rating, String review) async {
    await _firestore.collection('books').doc(docId).update({
      'progress': progress,
      'rating': rating,
      'review': review,
    });
  }

  Future<void> _deleteBook(String docId) async {
    await _firestore.collection('books').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    String userId = _auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('📚 Book Tracker Dashboard')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _bookTitleController,
              decoration: InputDecoration(
                labelText: 'Enter Book Title',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addBook,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('books').where('userId', isEqualTo: userId).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                var books = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    var book = books[index];
                    String docId = book.id;
                    String title = book['title'];
                    int progress = book['progress'];
                    double rating = (book['rating'] as num).toDouble();
                    String review = book['review'];

                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Progress: $progress%"),
                            RatingBar.builder(
                              initialRating: rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                              onRatingUpdate: (newRating) {
                                _updateBook(docId, progress, newRating, review);
                              },
                            ),
                            TextField(
                              decoration: const InputDecoration(labelText: "Write a review"),
                              controller: TextEditingController(text: review),
                              onSubmitted: (newReview) {
                                _updateBook(docId, progress, rating, newReview);
                              },
                            ),
                            Slider(
                              value: progress.toDouble(),
                              min: 0,
                              max: 100,
                              divisions: 10,
                              label: "$progress%",
                              onChanged: (newProgress) {
                                _updateBook(docId, newProgress.toInt(), rating, review);
                              },
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteBook(docId),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(),
          const Text("📖 Other Users' Libraries", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('books').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                var books = snapshot.data!.docs.where((doc) => doc['userId'] != userId).toList();

                return ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    var book = books[index];
                    String title = book['title'];
                    String username = book['username'];
                    int progress = book['progress'];
                    double rating = (book['rating'] as num).toDouble();
                    String review = book['review'];

                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Added by: $username"),
                            Text("Progress: $progress%"),
                            RatingBarIndicator(
                              rating: rating,
                              itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                              itemCount: 5,
                              itemSize: 20.0,
                            ),
                            if (review.isNotEmpty) Text("Review: $review"),
                          ],
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
    );
  }
}