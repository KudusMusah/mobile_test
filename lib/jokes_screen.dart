import "dart:convert";

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:mobile_test/models/jokes.dart';
import 'package:mobile_test/widgets/joke_card.dart';

class JokesScreen extends StatefulWidget {
  const JokesScreen({super.key});

  @override
  State<JokesScreen> createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  bool isLoading = true;
  bool isError = false;
  final _controller = TextEditingController();

  List<Joke> jokeList = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    try {
      for (int i = 0; i < 5; i++) {
        fetchJokes();
      }
    } catch (e) {}
    super.initState();
  }

  void fetchJokes() async {
    jokeList = [];
    try {
      var url = Uri.parse("https://v2.jokeapi.dev/joke/any");

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> items = await json.decode(response.body);

        jokeList.add(Joke(
            category: items["category"],
            title: items["setup"],
            answer: items["delivery"]));
        setState(() {
          isLoading = false;
        });
        return;
      } else {}
    } catch (e) {
      throw Exception("Something went wrong");
    }

    setState(() {
      isLoading = false;
      isError = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Expanded(
      child: ListView.builder(
        itemCount: jokeList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(jokeList[index].title),
            child: JokeCard(
                category: jokeList[index].category,
                jokeText: jokeList[index].title,
                ans: jokeList[index].answer),
          );
        },
      ),
    );

    if (isError) {
      content = const Center(
        child: Text("Something went wrong"),
      );
    }

    if (isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Jokes App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                        ),
                        labelText: "Search jokes"),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // filter()
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Swipe to delete",
                style: TextStyle(color: Colors.blue),
              ),
              ElevatedButton(
                onPressed: () {
                  try {
                    for (int i = 0; i < 5; i++) {
                      fetchJokes();
                    }
                  } catch (e) {}
                  super.initState();
                },
                child: const Text("Reload"),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          content,
        ],
      ),
    );
  }
}
