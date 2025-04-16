class Book {
  String id;
  String title;
  String author;
  String mood;
  String status; // e.g., "to-read", "reading", "read"
  int pages;
  int year;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.mood,
    required this.status,
    required this.pages,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'mood': mood,
      'status': status,
      'pages': pages,
      'year': year,
    };
  }

  factory Book.fromMap(String id, Map<String, dynamic> data) {
    return Book(
      id: id,
      title: data['title'],
      author: data['author'],
      mood: data['mood'],
      status: data['status'],
      pages: data['pages'],
      year: data['year'],
    );
  }
}