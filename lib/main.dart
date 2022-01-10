import 'package:flutter/material.dart';
import 'package:signup_movie_api/screens/home_movie_screen.dart';
import 'package:signup_movie_api/screens/login_screen.dart';
import 'package:signup_movie_api/screens/register_data.dart';
import 'package:signup_movie_api/screens/registration_screen.dart';
import 'package:signup_movie_api/screens/welcome_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(RegisterDataAdapter());
  await Hive.initFlutter();
  Box box = await Hive.openBox<RegisterData>('box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter ',
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        HomeScreen.id: (context) => const HomeScreen()
      },
    );
  }
}
