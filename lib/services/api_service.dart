import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wiser_clone_app/models/book.dart';

class ApiService {
  static final _db = FirebaseFirestore.instance;

  Future<List<Book>> getBooks() async {
    final snapshot = await _db.collection("books").get();
    List<Book> books = [];
    for (var doc in snapshot.docs) {
      books.add(Book.fromMap({'id': doc.id, ...doc.data()}));
    }

    return books;
  }

  Future<void> editBook(Book book) async {
    await _db.collection("books").doc(book.id).set(book.toMap());
  }
}
