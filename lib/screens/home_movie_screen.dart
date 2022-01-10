import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<dynamic>> fetchData() async {
    Response response = await http.post(
      Uri.parse('https://hoblist.com/api/movieList'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "category": "movies",
        "language": "kannada",
        "genre": "all",
        "sort": "voting"
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['result'];
    } else {
      throw Exception('Failed to create album.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "MOVIES",
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blueAccent),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  myDialog();
                },
                icon: const Icon(
                  Icons.info,
                  color: Colors.blueAccent,
                ))
          ],
        ),
        body: FutureBuilder<List<dynamic>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final movieData = snapshot.data![index];
                      return SizedBox(
                          width: double.infinity, child: myCard(movieData));
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  myDialog() => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text("Company Info"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Company: Geeksynergy Technologies Pvt Ltd"),
                Text("Address: Sanjayanagar, Bengaluru-56"),
                Text("Phone: XXXXXXXXX09"),
                Text("Email: XXXXXX@gmail.com"),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]);
      });
}

Widget myCard(dynamic data) {
  final poster = data['poster'];
  final title = data['title'];
  final genre = data['genre'];
  final language = data["language"];
  final vote = data['voting'].toString();
  final pageView = data['pageViews'].toString();
  String director = data['director'].toString();
  director = director.substring(1, (director.length - 1));
  String stars = data['stars'].toString();
  stars = stars.substring(1, (stars.length - 1));

  return Card(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        children: [
          Column(
            children: [
              const Icon(
                Icons.arrow_drop_up_sharp,
                size: 50,
              ),
              Text(vote),
              const Icon(
                Icons.arrow_drop_down_sharp,
                size: 50,
              ),
              const Text("Votes")
            ],
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              height: 120,
              width: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      poster,
                    ),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text("Genre: $genre",
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text("Director: $director",
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text("Starring: $stars",
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text("Language: $language",
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text("$pageView views| Voted by $vote",
                    style: const TextStyle(color: Colors.blueAccent))
              ],
            ),
          )
        ],
      ),
      TextButton(
        onPressed: () {},
        child: const Text(
          "Watch Trailer",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        style: TextButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
      )
    ],
  ));
}
