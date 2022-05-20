import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

// 1. Создаём класс на основе "ChangeNotifier". Засунем его потом в "context".
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
  // 2. Создаём объект - экземпляр класса, который в контекст запихнём.
  RandomColor newRandomColor = RandomColor(
      true,
      const Color.fromRGBO(255, 215, 0, 1),
      const Color.fromRGBO(30, 144, 255, 1));

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 3. В "ChangeNotifierProvider" заворачиваем то, что нужно обновлять/перестраивать.
    return ChangeNotifierProvider<RandomColor>(
      // 4. Засовываем наш объект класса "ChangeNotifier" в новый "контекст"
      create: ((context) => newRandomColor),
      child: const MaterialApp(
        // 5. Чтоб "новый контекст" заработал, нужно новый "билд".
        // Поэтому выносим остальной код в отдельный виджет.
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // 6. Вот сдесь уже нужный нам контекст содержащий объект нашего "ChangeNotifier" класса.
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
