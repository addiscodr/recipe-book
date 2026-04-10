import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login", style: TextStyle(fontSize: 24)),
      ),
      body: _buildUI(context),

      //
    );
  }

  Widget _buildUI(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_title(context)],
    );
  }

  Widget _title(BuildContext context) {
    return const Row(
      children: [
        Text("Recipe", style: TextStyle(fontSize: 36)),
        Text("Book", style: TextStyle(fontSize: 36, color: Colors.deepOrange)),
      ],
    );
  }
}
