import 'package:flutter/material.dart';
import 'package:wiser_clone_app/core/app_colors.dart';
import 'package:wiser_clone_app/models/book.dart';
import 'package:wiser_clone_app/repositories/recent_books_repository.dart';
import 'package:wiser_clone_app/services/ai_service.dart';

class SummaryPage extends StatefulWidget {
  final Book book;

  const SummaryPage({super.key, required this.book});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final recentBooksRepository = RecentBooksRepository();
  String dynamicDescription = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    recentBooksRepository.addRecentBook(widget.book);
    AiService.getBookDescription(widget.book).then((value) {
      if (mounted) {
        setState(() {
          isLoading = false;
          dynamicDescription = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Summary ${widget.book.name}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Builder(
          builder: (context) {
            if (isLoading) {
              return Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '*AI generated text',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: AppColors.gray),
                ),
                const SizedBox(height: 16),
                Text(
                  dynamicDescription.trim(),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
