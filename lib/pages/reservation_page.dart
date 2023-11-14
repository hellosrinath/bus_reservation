import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../customwidgets/reservation_item_body_view.dart';
import '../customwidgets/reservation_item_header_view.dart';
import '../customwidgets/search_box.dart';
import '../models/reservation_expansion_item.dart';
import '../providers/app_data_provider.dart';
import '../utils/helper_functions.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  bool isFirst = true;
  List<ReservationExpansionItem> items = [];

  @override
  void didChangeDependencies() {
    if (isFirst) {
      _getData();
    }
    super.didChangeDependencies();
  }

  _getData() async {
    final reservations =
        await Provider.of<AppDataProvider>(context, listen: false)
            .getAllReservations();
    if (!context.mounted) return;
    items = Provider.of<AppDataProvider>(context, listen: false)
        .getExpansionItem(reservations);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBox(onSubmit: (value) {
              debugPrint('Search Text: $value');
              _search(value);
            }),
            ExpansionPanelList(
              expansionCallback: (index, isExpanded) {
                setState(() {
                  items[index].isExpanded = isExpanded;
                });
              },
              children: items
                  .map(
                    (item) => ExpansionPanel(
                      headerBuilder: (context, isExpanded) =>
                          ReservationItemHeaderView(
                        header: item.header,
                        body: item.body,
                      ),
                      body: ReservationItemBodyView(body: item.body),
                      isExpanded: item.isExpanded,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _search(String value) async {
    final datas = await Provider.of<AppDataProvider>(context, listen: false)
        .getReservationByMobile(value);
    if (datas.isEmpty) {
      if (!context.mounted) return;
      showMessage(context, 'No Record Found');
      return;
    }
    setState(() {
      items = Provider.of<AppDataProvider>(context, listen: false)
          .getExpansionItem(datas);
    });
  }
}
