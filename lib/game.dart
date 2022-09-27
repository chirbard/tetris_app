import 'package:flutter/material.dart';

class MyGame extends StatefulWidget {
  const MyGame({Key? key}) : super(key: key);

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
            ),
          ),
          Container(
            color: const Color(0xFF1e1e1e),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF010101),
                    ),
                    width: 60,
                    height: 60,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF010101),
                    ),
                    width: 60,
                    height: 60,
                  ),
                  IconButton(
                    color: const Color(0xFF010101),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: const Color(0xFF010101),
                  //   ),
                  //   width: 60,
                  //   height: 60,
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF010101),
                    ),
                    width: 60,
                    height: 60,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}