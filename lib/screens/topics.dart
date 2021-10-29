import 'package:flutter/material.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('about'),
        backgroundColor: Colors.purple,
      ),
      body: const Center(
        child: Text('Topics...'),
      ),
    );
    ;
  }
}
