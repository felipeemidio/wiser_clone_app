import 'package:flutter/material.dart';
import 'package:wiser_clone_app/models/book.dart';

class FreeBookCard extends StatelessWidget {
  final Book book;
  const FreeBookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 180,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color(0xFFFAF4E4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.network(book.capeUrl),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  book.category.name.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                Text(
                  book.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text('by ${book.author}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
