import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, required this.callback});
  final Function callback;

  onQueryChanged(String newQuery) {
    callback(newQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onQueryChanged,
        decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            hintText: "Search",
            labelText: "Search",
            suffixIcon: Icon(Icons.search)),
      ),
    );
  }
}