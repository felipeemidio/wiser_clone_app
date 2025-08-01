import 'dart:convert';

import 'package:wiser_clone_app/models/category.dart';

class Book {
  final String name;
  final String author;
  final BookCategory category;
  final bool isTrend;
  final String capeUrl;

  const Book({
    required this.name,
    required this.author,
    required this.category,
    required this.capeUrl,
    this.isTrend = false,
  });

  factory Book.fromMap(Map<String, dynamic> json) {
    return Book(
      name: json['name'],
      author: json['author'],
      category: BookCategory(name: json['category'], icon: BookCategoryFactory.iconsMap[json['category']]!),
      capeUrl: json['capeUrl'],
      isTrend: json['isTrend'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'author': author,
      'category': category.name,
      'capeUrl': capeUrl,
      'isTrend': isTrend,
    };
  }

  factory Book.fromJson(String json) {
    return Book.fromMap(jsonDecode(json));
  }

  String toJson() => jsonEncode(toMap());

  String stringfy() {
    return '${name.toLowerCase()} ${author.toLowerCase()}';
  }
}
