import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:signup_movie_api/screens/register_data.dart';
import 'home_movie_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_Screen";

  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  late Box<RegisterData> box;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box<RegisterData>('box');
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      controller: emailEditingController,
      decoration: const InputDecoration(
        hintText: 'Enter your email',
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
    final passwordField = TextField(
      obscureText: true,
      controller: passwordEditingController,
      decoration: const InputDecoration(
        hintText: 'Enter your password.',
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blueAccent),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Flexible(
              child: Hero(
                  tag: 'logo',
                  child: Icon(
                    Icons.movie,
                    size: 100,
                    color: Colors.lightBlueAccent,
                  )),
            ),
            const SizedBox(height: 40.0),
            emailField,
            const SizedBox(height: 8.0),
            passwordField,
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    if (box.containsKey(emailEditingController.text) &&
                        box.get(emailEditingController.text)!.password ==
                            passwordEditingController.text) {
                      await Navigator.pushNamed(context, HomeScreen.id);
                      Navigator.pop(context);
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Invalid Credentials"),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Done'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Log In',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
