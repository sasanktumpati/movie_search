import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final Function(String) onSearch;

  SearchBox({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        onChanged: onSearch,
        decoration: InputDecoration(
          hintText: 'Search movies by title',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
