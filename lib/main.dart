import 'package:flutter/material.dart';

import 'view/home/home_page.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(),
    );
  }
}
