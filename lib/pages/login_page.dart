import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: _buildUI(context)));
  }

  Widget _buildUI(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_title(context), _loginForm(context)],
      ),
    );
  }

  Widget _title(BuildContext context) {
    return const Row(
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
    );
  }

  Widget _loginForm(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(decoration: InputDecoration(hintText: "Username")),
            TextFormField(decoration: InputDecoration(hintText: "Password")),
            _loginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text(
          "Login",
          style: TextStyle(color: Colors.black54, fontSize: 24),
        ),
      ),
    );
  }
}
