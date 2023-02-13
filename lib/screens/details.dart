/*
* Author: Giao U
* Page: this detail page is to show the picked location
* */
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: Text("Hello World! This is $title"),
    );
  }
}
