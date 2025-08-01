import 'package:flutter/material.dart';
import 'package:wiser_clone_app/models/book.dart';
import 'package:wiser_clone_app/pages/home_page.dart';
import 'package:wiser_clone_app/pages/summary_page.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wiser Clone App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF3587FB)),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/summary': (context) => SummaryPage(book: ModalRoute.of(context)!.settings.arguments as Book),
      },
    );
  }
}
