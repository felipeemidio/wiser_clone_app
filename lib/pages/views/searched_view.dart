import 'package:flutter/material.dart';
import 'package:wiser_clone_app/core/app_colors.dart';
import 'package:wiser_clone_app/models/book.dart';
import 'package:wiser_clone_app/widgets/app_button.dart';
import 'package:wiser_clone_app/widgets/book_detail_bottom_sheet.dart';
import 'package:wiser_clone_app/widgets/book_tile.dart';

class SearchedView extends StatelessWidget {
  final String search;
  final List<Book> books;
  final void Function() onGoToExplore;
  const SearchedView({
    super.key,
    required this.search,
    required this.books,
    required this.onGoToExplore,
  });

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              Text(
                'No book found!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'We\'ve searched more than 1000 books. We did not find any book for your search.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              AppButton(label: 'Explore All Books', onPressed: onGoToExplore),
            ],
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Result',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.neutral,

                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(books.length.toString()),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(
            books.length,
            (index) {
              final book = books[index];
              final isLast = index == books.length - 1;

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BookTile(
                    book: book,
                    onTap: () => showBookDetailBottomSheet(context, book),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: isLast ? const SizedBox.shrink() : const Divider(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
