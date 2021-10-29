import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/services/authentication.dart';
import 'dart:async';
import './screens/screens.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const SomethingWentWrong();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }
        return const Loading();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<User?>.value(
            initialData: AuthService().currentUser,
            value: AuthService().user,
          ),
        ],
        child: MaterialApp(
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())
          ],
          routes: {
            '/': (context) => LoginScreen(),
            '/topics': (context) => TopicsScreen(),
            '/profile': (context) => ProfileScreen(),
            '/about': (context) => AboutScreen(),
          },
          theme: ThemeData(
            fontFamily: 'Nunito',
            bottomAppBarTheme: const BottomAppBarTheme(
              color: Colors.black87,
            ),
            brightness: Brightness.dark,
            textTheme: const TextTheme(
              bodyText1: TextStyle(fontSize: 18, color: Colors.white),
              bodyText2: TextStyle(fontSize: 16, color: Colors.white),
              button: TextStyle(
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              headline4: TextStyle(fontWeight: FontWeight.bold),
              subtitle1: TextStyle(color: Colors.grey),
            ),
          ),
        ));
  }
}
