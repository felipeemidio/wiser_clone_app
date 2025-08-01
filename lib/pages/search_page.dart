import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wiser_clone_app/core/app_colors.dart';
import 'package:wiser_clone_app/models/book.dart';
import 'package:wiser_clone_app/models/category.dart';
import 'package:wiser_clone_app/pages/views/no_search_view.dart';
import 'package:wiser_clone_app/pages/views/searched_view.dart';
import 'package:wiser_clone_app/pages/views/searching_view.dart';
import 'package:wiser_clone_app/services/api_service.dart';

class SearchPage extends StatefulWidget {
  final void Function() onGoToExplorePage;
  const SearchPage({super.key, required this.onGoToExplorePage});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode _focus = FocusNode();
  final _searchFieldcontroller = TextEditingController();
  final _scrollController = ScrollController();
  final _apiService = ApiService();

  bool _isAppBarCollapsed = false;
  bool _isSearching = false;
  bool _isLoading = false;
  Timer? _searchTimer;
  String? _lastSearchText;
  List<Book> _lastSearchResult = [];
  Map<BookCategory, List<Book>> bookByCategory = {};
  List<Book> trendingBooks = <Book>[];
  List<Book> books = [];

  _onScroll() {
    if (_scrollController.offset > 120 && !_isAppBarCollapsed) {
      setState(() {
        _isAppBarCollapsed = true;
      });
    } else if (_scrollController.offset <= 120 && _isAppBarCollapsed) {
      setState(() {
        _isAppBarCollapsed = false;
      });
    }
  }

  _onFocusSearchField() {
    if (_isSearching != _focus.hasFocus) {
      setState(() {
        _isSearching = _focus.hasFocus;
      });
    }
  }

  _doSearch(String text) {
    if (text.isEmpty) {
      setState(() {
        _lastSearchResult = [];
        _lastSearchText = null;
        _isLoading = false;
      });
      return;
    }
    if (_lastSearchText != text) {
      setState(() {
        _lastSearchResult = books.where((book) => book.stringfy().contains(text.toLowerCase())).toList();
        _lastSearchText = text;
        _isLoading = false;
      });
    }
  }

  _onSearch() {
    final text = _searchFieldcontroller.text;
    if (_lastSearchText == text || (text.isEmpty && _lastSearchText == null)) {
      return;
    }
    _searchTimer?.cancel();
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    _searchTimer = Timer(
      const Duration(seconds: 1),
      () => _doSearch(text),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _focus.addListener(_onFocusSearchField);
    _searchFieldcontroller.addListener(_onSearch);

    _isLoading = true;
    _apiService.getBooks().then((books) {
      this.books = books;
      for (var book in books) {
        if (book.isTrend) {
          trendingBooks.add(book);
        }
        if (bookByCategory.containsKey(book.category)) {
          bookByCategory[book.category]!.add(book);
        } else {
          bookByCategory[book.category] = [book];
        }
      }
      if (context.mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchFieldcontroller.removeListener(_onSearch);
    _searchFieldcontroller.dispose();
    _focus.removeListener(_onFocusSearchField);
    _focus.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          centerTitle: _isAppBarCollapsed,
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          toolbarHeight: 120,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!_isSearching)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SizedBox(
                    height: 40,
                    child: Text(
                      'Search',
                      textAlign: _isAppBarCollapsed ? TextAlign.center : TextAlign.left,
                      style: _isAppBarCollapsed
                          ? TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
                          : TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                    ),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: _searchFieldcontroller,
                      builder: (context, value, _) {
                        return TextFormField(
                          focusNode: _focus,
                          controller: _searchFieldcontroller,
                          onFieldSubmitted: (value) => _onSearch(),
                          decoration: InputDecoration(
                            filled: true,
                            hint: Text(
                              "Type title or author",
                              style: TextStyle(color: AppColors.gray, fontSize: 16),
                            ),
                            prefixIconColor: AppColors.gray,
                            fillColor: AppColors.neutral,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),

                            prefixIcon: Icon(Icons.search),
                            suffix: value.text.isEmpty
                                ? null
                                : GestureDetector(
                                    onTap: () {
                                      _searchFieldcontroller.clear();
                                      setState(() {
                                        _lastSearchText = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.gray,
                                      ),
                                      padding: const EdgeInsets.all(2),
                                      child: Icon(
                                        Icons.clear,
                                        size: 12,
                                        color: AppColors.neutral,
                                      ),
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (_isSearching)
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: TextButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          _searchFieldcontroller.clear();
                          setState(() {
                            _isSearching = false;
                            _lastSearchText = null;
                            _lastSearchResult = [];
                          });
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: AppColors.blue),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Builder(
              builder: (context) {
                if (_isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (_isSearching) {
                  if (_lastSearchText != null) {
                    return SearchedView(
                      search: _lastSearchText!,
                      books: _lastSearchResult,
                      onGoToExplore: widget.onGoToExplorePage,
                    );
                  }
                  return SearchingView(
                    trendingBooks: trendingBooks,
                  );
                }
                return NoSearchView(
                  bookByCategory: bookByCategory,
                  trendingBooks: trendingBooks,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
