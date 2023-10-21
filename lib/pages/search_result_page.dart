import 'package:bus_reservation_udemy/models/but_route.dart';
import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    final BusRoute route = argList[0];
    final String departureDate = argList[1];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Text(
            'Showing Result for ${route.cityFrom} to ${route.cityTo} on $departureDate',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
