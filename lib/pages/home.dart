import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key, required this.title});
  late String title;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
