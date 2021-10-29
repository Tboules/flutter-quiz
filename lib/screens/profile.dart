import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/services/authentication.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('profile...'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: TextButton(
          child: Text('Logout'),
          style: TextButton.styleFrom(
              backgroundColor: Colors.red, primary: Colors.white),
          onPressed: () async {
            await auth.signOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
        ),
      ),
    );
  }
}
