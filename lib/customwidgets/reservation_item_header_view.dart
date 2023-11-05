import 'package:bus_reservation_udemy/models/reservation_expansion_item.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ReservationItemHeaderView extends StatelessWidget {
  final ReservationExpansionHeader header;
  final ReservationExpansionBody body;

  const ReservationItemHeaderView({
    super.key,
    required this.header,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('${header.departureDate} ${header.schedule.departureTime}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${header.schedule.busRoute.routeName}-${header.schedule.bus.busType}'),
            Text(
                'Booking Time: ${getFormattedDate(DateTime.fromMicrosecondsSinceEpoch(header.timestamp), pattern: 'EEE MMM dd yyyy HH:mm')}'),
            Text('Customer Name: ${body.customer.customerName}'),
            Text('Customer Mobile: ${body.customer.mobile}'),
            Text('Customer Email: ${body.customer.email}'),
            Text('Total Seat: ${body.totalSeatBooked}'),
            Text('Seat Number: ${body.seatNumbers}'),
            Text('Total Price: $currency${body.totalPrice}'),
          ],
        ),
      ),
    );
  }
}
