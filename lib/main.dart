import 'package:bus_reservation_udemy/pages/search_page.dart';
import 'package:bus_reservation_udemy/pages/search_result_page.dart';
import 'package:bus_reservation_udemy/providers/app_data_provider.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppDataProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        brightness: Brightness.dark,
      ),
      home: const SearchPage(),
      routes: {
        routeNameHome: ((context) => const SearchResultPage()),
        routeNameSearchResultPage: (context) => const SearchResultPage(),
      },
    );
  }
}