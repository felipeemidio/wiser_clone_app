import 'package:flutter/material.dart';
import 'package:wiser_clone_app/models/book.dart';
import 'package:wiser_clone_app/widgets/book_detail_bottom_sheet.dart';
import 'package:wiser_clone_app/widgets/book_with_title_card.dart';
import 'package:wiser_clone_app/widgets/title_label.dart';

class SearchingView extends StatelessWidget {
  final List<Book> trendingBooks;
  const SearchingView({super.key, required this.trendingBooks});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleLabel(title: 'Trending Now'),
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: trendingBooks.length,
            itemBuilder: (context, index) {
              final isFirst = index == 0;
              final book = trendingBooks[index];
              return Padding(
                padding: isFirst ? EdgeInsets.zero : const EdgeInsets.only(left: 16),
                child: BookWithTitleCard(
                  onTap: () => showBookDetailBottomSheet(context, book),
                  book: book,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
