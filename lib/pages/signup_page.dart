import 'package:flutter/material.dart';
import 'package:recipe_book/pages/login_page.dart';
import '/services/auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirmPassword;

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
        children: [_title(context), _signupForm(context)],
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
            color: Color.fromARGB(255, 129, 48, 19),
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _signupForm(BuildContext context) {
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
              onSaved: (value) {
                email = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(hintText: "Username"),
            ),
            TextFormField(
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
            SizedBox(height: 2),
            TextFormField(
              onSaved: (value) {
                confirmPassword = value;
              },
              obscureText: true,
              validator: (value) {
                if (value == null || value.length < 5) {
                  return "Passwords don't match";
                }
                return null;
              },
              decoration: InputDecoration(hintText: "Confirm Password"),
            ),
            SizedBox(height: 20),
            _signupButton(context),
            _signinText(context),
          ],
        ),
      ),
    );
  }

  Widget _signupButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12,
            ), // Set your desired radius here
          ),
          minimumSize: const Size(150, 60),
          backgroundColor: const Color.fromARGB(255, 129, 48, 19),
        ),
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            bool result = await AuthService().login(email!, password!);

            if (result) {
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, "/home");
              ScaffoldMessenger.of(
                // ignore: use_build_context_synchronously
                context,
              ).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                    "Registration Successful",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    "Registration Failed",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            }
          }
        },
        child: const Text(
          "Register",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  Widget _signinText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Already have an account? "),
            Text(
              "Sign In",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
