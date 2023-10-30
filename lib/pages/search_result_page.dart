import 'package:bus_reservation_udemy/models/but_route.dart';
import 'package:bus_reservation_udemy/providers/app_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
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
          Consumer<AppDataProvider>(
            builder: (context, provider, _) => FutureBuilder(
              future: provider.getScheduleByRouteName(route.routeName),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final scheduleList = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: scheduleList
                        .map((schedule) => ListTile(
                              title: Text(schedule.bus.busName),
                              subtitle: Text(schedule.bus.busType),
                              trailing:
                                  Text("$currency ${schedule.ticketPrice}"),
                            ))
                        .toList(),
                  );
                }
                if (snapshot.hasError) {
                  return const Text("Failed to fetch data");
                }
                return const Text('Please wait...');
              },
            ),
          ),
        ],
      ),
    );
  }
}
