import 'package:flutter/material.dart';
import 'package:wiser_clone_app/models/book.dart';

class BookCard extends StatelessWidget {
  final double width;
  final double height;
  final Book book;
  const BookCard({
    super.key,
    this.width = 130,
    this.height = 200,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(book.capeUrl, fit: BoxFit.cover),
      ),
    );
  }
}
