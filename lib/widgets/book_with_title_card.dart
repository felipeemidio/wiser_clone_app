import 'package:flutter/material.dart';
import 'package:wiser_clone_app/models/book.dart';
import 'package:wiser_clone_app/widgets/book_card.dart';

class BookWithTitleCard extends StatelessWidget {
  final Book book;
  final void Function()? onTap;
  const BookWithTitleCard({
    super.key,
    required this.book,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          BookCard(book: book),
          const SizedBox(height: 8),
          SizedBox(
            width: 130,
            child: Text(
              book.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
