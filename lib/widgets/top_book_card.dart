import 'package:flutter/material.dart';
import 'package:wiser_clone_app/models/book.dart';
import 'package:wiser_clone_app/widgets/book_card.dart';

class TopBookCard extends StatelessWidget {
  final int index;
  final Book book;
  const TopBookCard({super.key, required this.index, required this.book});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 0,
            left: index >= 10 ? 10 : 30,
            child: Text(
              index.toString(),
              style: TextStyle(
                fontSize: 180,
                fontWeight: FontWeight.w800,
                color: Colors.black26,
                height: 0.7,
                letterSpacing: -45,
              ),
            ),
          ),
          Positioned(
            bottom: 4,
            left: (index >= 10 ? 12 : 30) + 3,
            child: Text(
              index.toString(),
              style: TextStyle(
                fontSize: 170,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).scaffoldBackgroundColor,
                height: 0.7,
                letterSpacing: (index >= 10 ? 3 : 0) - 45,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: BookCard(
              book: book,
            ),
          ),
        ],
      ),
    );
  }
}
