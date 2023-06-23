import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _formKey = GlobalKey();
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search what you are looking for",
          prefixIcon: Icon(Icons.search),
          prefixIconColor: Colors.black38,
        ),
      ),
    );
  }
}
