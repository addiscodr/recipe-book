import 'package:flutter/material.dart';
import 'package:recipe_book/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  String? username;
  String? password;

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
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: "emilys",
              onSaved: (value) {
                username = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter username";
                }
                return null;
              },
              decoration: InputDecoration(hintText: "Username"),
            ),
            TextFormField(
              initialValue: "emilyspass",
              onSaved: (value) {
                password = value;
              },
              obscureText: true,
              validator: (value) {
                if (value == null || value.length < 5) {
                  return "Enter a valid password";
                }
                return null;
              },
              decoration: InputDecoration(hintText: "Password"),
            ),
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
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            bool result = await AuthService().login(username!, password!);
            print(result);

            if (result) {
              ScaffoldMessenger.of(
                // ignore: use_build_context_synchronously
                context,
              ).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                    "Login Successful",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(
                // ignore: use_build_context_synchronously
                context,
              ).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("Login Failed", style: TextStyle(fontSize: 18)),
                ),
              );
            }
          }
        },
        child: const Text(
          "Login",
          style: TextStyle(color: Colors.black54, fontSize: 24),
        ),
      ),
    );
  }
}
