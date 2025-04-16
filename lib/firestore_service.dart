import 'package:cloud_firestore/cloud_firestore.dart';
import 'book_model.dart';

class FirestoreService {
  final CollectionReference books = FirebaseFirestore.instance.collection('books');

  Future<void> addBook(Book book) async {
    await books.doc(book.id).set(book.toMap());
  }

  Stream<List<Book>> getBooks() {
    return books.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Book.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList());
  }
}