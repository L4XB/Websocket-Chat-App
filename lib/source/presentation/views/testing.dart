import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: OutlinedButton(
                onPressed: () {
                  print("Connecting");
                  //WebsocketProvider().awaitMessages();
                },
                child: const Text("Connect")),
          )
        ],
      ),
    );
  }
}
