import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({super.key, required this.title});
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
