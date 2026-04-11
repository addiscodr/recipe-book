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
      body: SafeArea(child: _buildUI(context)),
    );
  }

  Widget _buildUI(BuildContext context) {
    return Container(child: Column(children: [_recipeTypeButtons(context)]));
  }

  Widget _recipeTypeButtons(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: FilledButton(
              onPressed: () {},
              child: const Text("🥕 Snack"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: FilledButton(
              onPressed: () {},
              child: const Text("🍕 Breakfast"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: FilledButton(
              onPressed: () {},
              child: const Text("🍝 Lunch"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: FilledButton(
              onPressed: () {},
              child: const Text("🥗 Dinner"),
            ),
          ),
        ],
      ),
    );
  }
}
