import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Recipe",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w300),
            ),
            Text(
              "Book",
              style: TextStyle(
                fontSize: 36,
                color: Colors.deepOrange,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return Container();
  }
}
