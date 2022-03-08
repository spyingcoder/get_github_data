import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_data/screens/home_screen.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),

      routes: {
        '/' : (context) => Home(),
      },

      initialRoute: '/',
    );
  }
}
