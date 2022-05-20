import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class RandomColor extends ChangeNotifier {
  bool _switchStatus;
  Color _titleColor;
  Color _figureColor;

  RandomColor(this._switchStatus, this._titleColor, this._figureColor);

  void getRandomColor() {
    _titleColor = Color.fromRGBO(
        Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), 1);
    _figureColor = Color.fromRGBO(
        Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), 1);
    _switchStatus = !_switchStatus;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  RandomColor newRandomColor = RandomColor(
      true,
      const Color.fromRGBO(255, 215, 0, 1),
      const Color.fromRGBO(30, 144, 255, 1));

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RandomColor>(
      create: ((context) => newRandomColor),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Homework Provider',
          style: TextStyle(color: context.watch<RandomColor>()._titleColor),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              color: context.watch<RandomColor>()._figureColor,
              width: 200,
              height: 200,
            ),
            Switch(
                value: context.watch<RandomColor>()._switchStatus,
                onChanged: (_) => context.read<RandomColor>().getRandomColor()),
          ],
        ),
      ),
    );
  }
}
