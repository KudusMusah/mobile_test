import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final String category;
  final String ans;
  final String jokeText;

  const JokeCard({
    super.key,
    required this.category,
    required this.jokeText,
    required this.ans,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 13.0,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                jokeText,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    ans,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.greenAccent,
                    ),
                  ),
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
