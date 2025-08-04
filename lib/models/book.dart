import 'dart:convert';

import 'package:wiser_clone_app/models/category.dart';

class Book {
  final String id;
  final String name;
  final String author;
  final String? description;
  final BookCategory category;
  final bool isTrend;
  final String capeUrl;

  const Book({
    required this.id,
    required this.name,
    required this.author,
    required this.description,
    required this.category,
    required this.capeUrl,
    this.isTrend = false,
  });

  factory Book.fromMap(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
      author: json['author'],
      description: json['description'] ?? '',
      category: BookCategory(name: json['category'], icon: BookCategoryFactory.iconsMap[json['category']]!),
      capeUrl: json['capeUrl'],
      isTrend: json['isTrend'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'description': description,
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

  Book copyWith({
    String? id,
    String? name,
    String? author,
    String? description,
    BookCategory? category,
    bool? isTrend,
    String? capeUrl,
  }) {
    return Book(
      id: id ?? this.id,
      name: name ?? this.name,
      author: author ?? this.author,
      description: description ?? this.description,
      category: category ?? this.category,
      isTrend: isTrend ?? this.isTrend,
      capeUrl: capeUrl ?? this.capeUrl,
    );
  }
}
