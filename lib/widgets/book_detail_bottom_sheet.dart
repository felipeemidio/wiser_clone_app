import 'package:flutter/material.dart';
import 'package:wiser_clone_app/models/book.dart';
import 'package:wiser_clone_app/services/ai_service.dart';

Future<void> showBookDetailBottomSheet(BuildContext context, Book book) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => BookDetailBottomSheet(book: book),
  );
}

class BookDetailBottomSheet extends StatefulWidget {
  final Book book;
  const BookDetailBottomSheet({
    super.key,
    required this.book,
  });

  @override
  State<BookDetailBottomSheet> createState() => _BookDetailBottomSheetState();
}

class _BookDetailBottomSheetState extends State<BookDetailBottomSheet> {
  String dynamicDescription = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
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
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEFEFEF),
                    ),
                    child: IconButton(
                      iconSize: 24,
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_horiz),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Image.network(widget.book.capeUrl),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                widget.book.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.book.author,
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF969697), fontSize: 16),
              ),
              const SizedBox(height: 32),
              Text(
                'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              isLoading
                  ? Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    )
                  : Text(
                      dynamicDescription.trim(),
                      style: TextStyle(
                        color: Color(0xFF969697),
                      ),
                    ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
