import 'package:flutter/material.dart';
import 'package:wiser_clone_app/core/app_colors.dart';
import 'package:wiser_clone_app/models/book.dart';
import 'package:wiser_clone_app/services/api_service.dart';
import 'package:wiser_clone_app/widgets/book_detail_bottom_sheet.dart';
import 'package:wiser_clone_app/widgets/free_book_card.dart';
import 'package:wiser_clone_app/widgets/title_label.dart';
import 'package:wiser_clone_app/widgets/top_book_card.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _apiService = ApiService();
  late final int weekday = DateTime.now().weekday;
  final allWeekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final freeBooks = [];
  List<Book> books = [
    // Book(
    //   name: 'The Lord of the Rings',
    //   author: 'James Clear',
    //   category: BookCategoryFactory.drama,
    //   capeUrl: 'https://m.media-amazon.com/images/I/81ANaVZk5LL.jpg',
    // ),
    // Book(
    //   name: 'The Lord of the Rings',
    //   author: 'James Clear',
    //   category: BookCategoryFactory.drama,
    //   capeUrl: 'https://m.media-amazon.com/images/I/81ANaVZk5LL.jpg',
    // ),
    // Book(
    //   name: 'The Lord of the Rings',
    //   author: 'James Clear',
    //   category: BookCategoryFactory.drama,
    //   capeUrl: 'https://m.media-amazon.com/images/I/81ANaVZk5LL.jpg',
    // ),
  ];

  @override
  void initState() {
    super.initState();
    _apiService.getBooks().then((books) {
      if (mounted) {
        setState(() {
          this.books = books;
          freeBooks.addAll([books.first, books.last]);
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
          'Explore',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFE8F5EC),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Streak: ',
                  style: TextStyle(color: Colors.green),
                ),
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 16,
                ),
                Text(
                  ' 0',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Badge.count(
            count: 1,
            child: Icon(Icons.card_giftcard_rounded),
          ),
          const SizedBox(width: 24),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(allWeekdays.length, (index) {
                  final past = weekday > index + 1;
                  final color = weekday == index + 1 ? AppColors.blue : AppColors.gray;
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: past ? AppColors.neutral : Colors.transparent,
                      border: Border.all(color: past ? AppColors.neutral : color, width: 1),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Text(
                      allWeekdays[index],
                      style: TextStyle(color: color),
                    ),
                  );
                }),
              ),
              const TitleLabel(title: 'Free Books'),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: freeBooks.length,
                  itemBuilder: (context, index) {
                    final isFirst = index == 0;

                    return Padding(
                      padding: isFirst ? EdgeInsets.zero : const EdgeInsets.only(left: 16),
                      child: GestureDetector(
                        onTap: () {
                          showBookDetailBottomSheet(context, freeBooks[index]);
                        },
                        child: FreeBookCard(
                          book: freeBooks[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const TitleLabel(title: 'Top Trending in Your Region'),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final isFirst = index == 0;
                    final book = books[index];
                    return Padding(
                      padding: isFirst ? EdgeInsets.zero : const EdgeInsets.only(left: 16),
                      child: GestureDetector(
                        onTap: () {
                          showBookDetailBottomSheet(context, book);
                        },
                        child: TopBookCard(
                          index: index + 1,
                          book: book,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const TitleLabel(title: 'Key Insights'),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final isFirst = index == 0;

                    return Padding(
                      padding: isFirst ? EdgeInsets.zero : const EdgeInsets.only(left: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.blue, width: 4),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            color: Colors.grey,
                            child: Image.network(
                              'https://m.media-amazon.com/images/I/81ANaVZk5LL.jpg',
                              width: 100,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
