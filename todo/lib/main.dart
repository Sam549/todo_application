import 'package:flutter/material.dart';
import 'package:todo/Pages/home_page.dart';
import 'package:todo/Pages/login_page.dart';
import 'package:todo/Pages/signup_page.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder? builder = _routes[settings.name];
        if (builder != null) {
          return MaterialPageRoute(builder: builder, settings: settings);
        }
        return MaterialPageRoute(builder: (context) => const NotFoundPage());
      },
    );
  }
}

final Map<String, WidgetBuilder> _routes = {
  '/': (context) => LoginPage(),
  '/signup': (context) => SignupPage(),
  '/home': (context) => HomePage(key: null), // Create an instance of HomePage
};