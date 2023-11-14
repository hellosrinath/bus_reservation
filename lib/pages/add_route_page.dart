import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../datasource/temp_db.dart';
import '../models/bus_route.dart';
import '../providers/app_data_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class AddRoutePage extends StatefulWidget {
  const AddRoutePage({super.key});

  @override
  State<AddRoutePage> createState() => _AddRoutePageState();
}

class _AddRoutePageState extends State<AddRoutePage> {
  final _fromKey = GlobalKey<FormState>();
  String? from, to;
  final distanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Route'),
      ),
      body: Form(
        key: _fromKey,
        child: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            shrinkWrap: true,
            children: [
              DropdownButtonFormField(
                onChanged: (value) {
                  setState(() {
                    from = value;
                  });
                },
                isExpanded: true,
                value: from,
                hint: const Text('Form'),
                items: cities
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 5),
              DropdownButtonFormField(
                onChanged: (value) {
                  setState(() {
                    to = value;
                  });
                },
                isExpanded: true,
                value: to,
                hint: const Text('To'),
                items: cities
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: distanceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Distance in Kilometre',
                  filled: true,
                  prefixIcon: Icon(Icons.social_distance_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _addRoute,
                    child: const Text('ADD ROUTE'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addRoute() {
    if (_fromKey.currentState!.validate()) {
      final route = BusRoute(
        routeId: TempDB.tableRoute.length + 1,
        routeName: '$from-$to',
        cityFrom: from!,
        cityTo: to!,
        distanceInKm: double.parse(distanceController.text),
      );
      Provider.of<AppDataProvider>(context, listen: false)
          .addRoute(route)
          .then((response) {
        if (response.responseStatus == ResponseStatus.SAVED) {
          showMessage(context, response.message);
          resetField();
        }
      });
    }
  }

  @override
  void dispose() {
    distanceController.dispose();
    super.dispose();
  }

  void resetField() {
    distanceController.clear();
  }
}
