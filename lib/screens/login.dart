import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/services/authentication.dart';
import 'package:quizapp/shared/bottom_nav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    auth.user.listen((User? user) {
      if (user == null) {
        return;
      } else {
        print(user);
        Navigator.pushNamed(context, '/topics');
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            Text(
              'Login to Start',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            const Text('Come On In!'),
            LoginButton(
              text: 'LOGIN WITH GOOGLE',
              icon: FontAwesomeIcons.google,
              color: Colors.black45,
              loginMethod: auth.googleSignIn,
            ),
            LoginButton(text: 'Continue as Guest', loginMethod: auth.anonLogIn)
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color? color;
  final IconData? icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {Key? key,
      required this.text,
      this.color,
      this.icon,
      required this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: TextButton.icon(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(30), backgroundColor: color),
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          label: Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
          onPressed: () async {
            var user = await loginMethod();
            print(user);
            if (user != null) {
              Navigator.pushNamed(context, '/topics');
            }
          },
        ));
  }
}
