import 'package:flutter/material.dart';
import 'package:wiser_clone_app/models/book.dart';
import 'package:wiser_clone_app/models/category.dart';
import 'package:wiser_clone_app/widgets/book_detail_bottom_sheet.dart';
import 'package:wiser_clone_app/widgets/book_with_title_card.dart';
import 'package:wiser_clone_app/widgets/title_label.dart';

class NoSearchView extends StatelessWidget {
  final Map<BookCategory, List<Book>> bookByCategory;
  final List<Book> trendingBooks;
  const NoSearchView({super.key, required this.bookByCategory, required this.trendingBooks});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleLabel(
          title: "Categories",
          arrow: true,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Builder(
            builder: (context) {
              final int half = (bookByCategory.length / 2).ceil();
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(half, (index) {
                      final category = bookByCategory.keys.elementAt(index);
                      return Padding(
                        padding: EdgeInsets.only(left: index == 0 ? 0 : 24),
                        child: Row(
                          children: [
                            Icon(category.icon, size: 36),
                            const SizedBox(width: 8),
                            Text(
                              category.name,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: List.generate(bookByCategory.length - half, (index) {
                      final category = bookByCategory.keys.elementAt(half + index);
                      return Padding(
                        padding: EdgeInsets.only(left: index == 0 ? 0 : 24),
                        child: Row(
                          children: [
                            Icon(category.icon, size: 36),
                            const SizedBox(width: 16),
                            Text(
                              category.name,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
        Column(
          children: [
            TitleLabel(
              title: bookByCategory.keys.first.name,
              arrow: true,
            ),
            SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bookByCategory.values.first.length,
                itemBuilder: (context, index) {
                  final isFirst = index == 0;
                  final book = bookByCategory.values.first[index];
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
        ),
      ],
    );
  }
}
