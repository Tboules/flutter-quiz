import 'package:flutter/material.dart';
import 'package:quizapp/shared/bottom_nav.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topics'),
        backgroundColor: Colors.purple,
      ),
      body: const Center(
        child: Text('Topics...'),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
