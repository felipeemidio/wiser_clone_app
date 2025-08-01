import 'dart:convert';

import 'package:wiser_clone_app/models/book.dart';
import 'package:wiser_clone_app/services/local_storage_service.dart';

class RecentBooksRepository {
  static final _key = 'recent_books';
  final _localStorageService = LocalStorageService();

  Future<List<Book>> getAll() async {
    final response = await _localStorageService.read(_key);
    final list = jsonDecode(response ?? '[]') as List;
    return list.map((e) => Book.fromMap(e)).toList();
  }

  Future<void> saveAll(List<Book> books) async {
    if (books.length > 5) {
      books = books.sublist(0, 5);
    }
    final structList = books.map((e) => e.toMap()).toList();
    await _localStorageService.write(_key, jsonEncode(structList));
  }

  Future<void> addRecentBook(Book book) async {
    final list = await getAll();
    list.insert(0, book);
    await saveAll(list);
  }
}
