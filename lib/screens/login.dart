import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/shared/bottom_nav.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('login'),
          backgroundColor: Colors.red,
        ),
        body: const Center(
          child: Text('Login...'),
        ),
        bottomNavigationBar: const BottomNav(),
      );
    } else {
      return const Text('not logged in...');
    }
  }
}
