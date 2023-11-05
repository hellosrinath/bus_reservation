import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final Function(String) onSubmit;

  const SearchBox({
    super.key,
    required this.onSubmit,
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Search With mobile',
          suffix: IconButton(
            onPressed: () {
              if (_searchController.text.isEmpty) return;
              widget.onSubmit(_searchController.text);
            },
            icon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
