import 'package:flutter/material.dart';

class BookCategory {
  final String name;
  final IconData icon;

  const BookCategory({
    required this.name,
    required this.icon,
  });

  @override
  bool operator ==(covariant BookCategory other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

class BookCategoryFactory {
  static final Map<String, IconData> iconsMap = {
    'Drama & Fiction': Icons.theater_comedy_outlined,
    'Carrer & Success': Icons.monetization_on_outlined,
    'Money & Investiments': Icons.health_and_safety_outlined,
    'Sex & Relationships': Icons.handshake_outlined,
    'Healty & Nutrition': Icons.health_and_safety_outlined,
  };

  static BookCategory get money => BookCategory(name: 'Money & Investiments', icon: iconsMap['Money & Investiments']!);
  static BookCategory get drama => BookCategory(name: 'Drama & Fiction', icon: iconsMap['Drama & Fiction']!);
  static BookCategory get carrer => BookCategory(name: 'Carrer & Success', icon: iconsMap['Carrer & Success']!);
  static BookCategory get relations =>
      BookCategory(name: 'Sex & Relationships', icon: iconsMap['Sex & Relationships']!);
  static BookCategory get health => BookCategory(name: 'Healty & Nutrition', icon: iconsMap['Healty & Nutrition']!);
}
