import 'package:flutter/material.dart';
import 'package:wiser_clone_app/core/app_colors.dart';
import 'package:wiser_clone_app/pages/explore_page.dart';
import 'package:wiser_clone_app/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageViewController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  _onGoToPage(int index) {
    setState(() {
      _currentPage = index;
    });
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedItemColor: AppColors.blue,
        currentIndex: _currentPage,
        onTap: _onGoToPage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
      body: PageView(
        controller: _pageViewController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const ExplorePage(),
          SearchPage(onGoToExplorePage: () => _onGoToPage(0)),
        ],
      ),
    );
  }
}
