import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final String? tooltipText;
  final dynamic Function(String query) onSubmit;

  const SearchField({super.key, this.tooltipText, required this.onSubmit});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _searchTextController = TextEditingController();

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 4),
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).backgroundColor),
          borderRadius: const BorderRadius.all(Radius.circular(40))),
      child: Row(children: <Widget>[
        Flexible(
          child: TextField(
            controller: _searchTextController,
            decoration: const InputDecoration(hintText: 'Enter a search term'),
            onSubmitted: widget.onSubmit,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: widget.tooltipText ?? '',
          onPressed: () {
            var searchText = _searchTextController.text;
            widget.onSubmit(searchText);
          },
        ),
      ]),
    );
  }
}
