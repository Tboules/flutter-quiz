import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('hello App'),
        ),
        body: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ThirdWidget();
  }
}

class ThirdWidget extends StatelessWidget {
  const ThirdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      // scrollDirection: Axis.horizontal,
      children: _cards(),
    );
  }

  List<Widget> _cards() {
    var sampList = [
      {'color': Colors.blue, 'num': 1},
      {'color': Colors.red, 'num': 2},
      {'color': Colors.green, 'num': 3},
      {'color': Colors.yellow, 'num': 4},
      {'color': Colors.teal, 'num': 5}
    ];
    return sampList.map((v) {
      var disp = v['num'];
      return Container(
        color: v['color'] as Color,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        height: 150,
        child: Text('$disp'),
      );
    }).toList();
  }
}
