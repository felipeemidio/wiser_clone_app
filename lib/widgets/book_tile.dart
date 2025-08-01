import 'package:flutter/material.dart';
import 'package:wiser_clone_app/core/app_colors.dart';
import 'package:wiser_clone_app/models/book.dart';
import 'package:wiser_clone_app/widgets/book_card.dart';

class BookTile extends StatelessWidget {
  final Book book;
  final void Function()? onTap;
  const BookTile({super.key, required this.book, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BookCard(book: book),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  book.category.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  book.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Ut mattis massa blandit urna semper gravida. Pellentesque sodales convallis dictum. '
                  'Phasellus sit amet luctus purus, nec tincidunt augue. Nullam commodo tempus.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8, color: AppColors.gray),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.menu_book_outlined, size: 20, color: AppColors.gray),
                    const SizedBox(width: 4),
                    Text(
                      "6 chapters",
                      style: TextStyle(fontSize: 16, color: AppColors.gray),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.access_time, size: 20, color: AppColors.gray),
                    const SizedBox(width: 4),
                    Text(
                      "12 min",
                      style: TextStyle(fontSize: 16, color: AppColors.gray),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.neutral,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.bookmark_outline),
                        const SizedBox(width: 4),
                        Text('Save'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right, size: 32, color: AppColors.gray),
        ],
      ),
    );
  }
}
