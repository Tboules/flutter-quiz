import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Loading();
      },
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Something Went Wrong'),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('loading'),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => HomeScreen(title: 'home'),
        '/list': (context) => ThirdWidget(),
        '/fire': (context) => FireTest(),
      },
      home: HomeScreen(title: 'home test'),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(child: AnimationTest()),
    );
  }
}

class ThirdWidget extends StatelessWidget {
  const ThirdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List')),
      body: ListView(
        children: _cards(),
      ),
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

class AnimationTest extends StatefulWidget {
  AnimationTest({Key? key}) : super(key: key);

  @override
  _AnimationTestState createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest> {
  double width = 100;
  double height = 100;
  Color color = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      curve: Curves.bounceInOut,
      color: color,
      width: width,
      height: height,
      child: TextButton(
        child: const Text('Random'),
        onPressed: () {
          setState(() {
            width = Random().nextDouble() * 400;
            height = Random().nextDouble() * 400;

            int r = Random().nextInt(255);
            int g = Random().nextInt(255);
            int b = Random().nextInt(255);
            color = Color.fromRGBO(r, g, b, .8);
          });
          Navigator.pushNamed(context, '/fire');
        },
      ),
    );
  }
}

class FireTest extends StatelessWidget {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Data')),
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
          future: db.collection('test_col').doc('test_doc').get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<dynamic, dynamic> data =
                  snapshot.data!.data()! as Map<dynamic, dynamic>;

              int number = data['number'];

              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(data['text']),
                    Text('$number'),
                    const Text('hello'),
                  ]);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
