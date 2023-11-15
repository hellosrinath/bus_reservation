import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../customwidgets/login_alert_dialog.dart';
import '../models/bus_model.dart';
import '../models/bus_route.dart';
import '../models/bus_schedule.dart';
import '../providers/app_data_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final _formKey = GlobalKey<FormState>();
  String? busType;
  BusRoute? busRoute;
  Bus? bus;
  TimeOfDay? timeOfDay;
  final priceController = TextEditingController();
  final discountController = TextEditingController();
  final feeController = TextEditingController();

  @override
  void didChangeDependencies() {
    _getData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Schedule'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            shrinkWrap: true,
            children: [
              Consumer<AppDataProvider>(
                builder: (context, provider, child) => DropdownButtonFormField(
                  onChanged: (value) {
                    setState(() {
                      bus = value;
                    });
                  },
                  isExpanded: true,
                  value: bus,
                  hint: const Text('Select Bus'),
                  items: provider.busList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text('${e.busName}-${e.busType}'),
                        ),
                      )
                      .toList(),
                ),
              ),
              Consumer<AppDataProvider>(
                builder: (context, provider, child) => DropdownButtonFormField(
                  onChanged: (value) {
                    setState(() {
                      busRoute = value;
                    });
                  },
                  isExpanded: true,
                  value: busRoute,
                  hint: const Text('Select Route'),
                  items: provider.routeList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.routeName),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: priceController,
                decoration: const InputDecoration(
                  hintText: 'Ticket Price',
                  filled: true,
                  prefixIcon: Icon(Icons.price_change),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: discountController,
                decoration: const InputDecoration(
                  hintText: 'Discount(%)',
                  filled: true,
                  prefixIcon: Icon(Icons.price_change),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: feeController,
                decoration: const InputDecoration(
                  hintText: 'Processing Fee',
                  filled: true,
                  prefixIcon: Icon(Icons.price_change),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _selectTime,
                    child: const Text('Select Departure Time: '),
                  ),
                  Text(timeOfDay == null
                      ? 'No Time Chosen'
                      : getFormattedTime(timeOfDay!)),
                ],
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: addSchedule,
                    child: const Text('Add Schedule'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectTime() async {
    final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: true,
            ),
            child: child!,
          );
        });
    if (time != null) {
      setState(() {
        timeOfDay = time;
      });
    }
  }

  void addSchedule() {
    if (timeOfDay == null) {
      showMessage(context, 'Please, select a departure date');
      return;
    }
    if (_formKey.currentState!.validate()) {
      final schedule = BusSchedule(
        /*    scheduleId: TempDB.tableSchedule.length + 1,*/
        bus: bus!,
        busRoute: busRoute!,
        departureTime: getFormattedTime(timeOfDay!),
        ticketPrice: int.parse(priceController.text),
        discount: int.parse(discountController.text),
        processingFee: int.parse(feeController.text),
      );

      Provider.of<AppDataProvider>(context, listen: false)
          .addSchedule(schedule)
          .then((response) {
        if (response.responseStatus == ResponseStatus.SAVED) {
          showMessage(context, response.message);
          resetFields();
        } else if (response.responseStatus == ResponseStatus.EXPIRED ||
            response.responseStatus == ResponseStatus.UNAUTHORIZED) {
          showLoginAlertDialog(
            context: context,
            message: response.message,
            callback: () {
              Navigator.pushNamed(context, routeNameLoginPage);
            },
          );
        }
      });
    }
  }

  @override
  void dispose() {
    priceController.dispose();
    discountController.dispose();
    feeController.dispose();
    super.dispose();
  }

  void resetFields() {
    priceController.clear();
    discountController.clear();
    feeController.clear();
  }

  void _getData() {
    Provider.of<AppDataProvider>(context, listen: false).getAllBus();
    Provider.of<AppDataProvider>(context, listen: false).getAllRoute();
  }
}
