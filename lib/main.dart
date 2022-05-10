// import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random colors',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Homework Provider',
            style: TextStyle(color: Colors.green),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                color: Colors.blue,
                width: 200,
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
