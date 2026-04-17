import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/pages/home_page.dart';
import 'package:recipe_book/pages/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String? email;
  String? password;
  String? confirmPassword;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void registration() async {
    if (email != null && password != null && confirmPassword != null) {
      setState(() {
        isLoading = true;
      });

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } on FirebaseAuthException catch (e) {
        print("FIREBASE ERROR CODE: ${e.code}");
        print("FIREBASE ERROR MESSAGE: ${e.message}");

        String message = "Something went wrong";

        if (e.code == "weak-password") {
          message = "Weak Password";
        } else if (e.code == "email-already-in-use") {
          message = "Account Already Exists";
        } else if (e.code == "invalid-email") {
          message = "Invalid Email";
        } else if (e.code == "network-request-falied") {
          message = "No Internet Connection";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              message,
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
          ),
        );
      }

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 60),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset("assets/images/pan.png"),
                SizedBox(height: 60),

                /// EMAIL
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Color(0xfff4f5f9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                    ),
                  ),
                ),

                SizedBox(height: 15),

                /// PASSWORD
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Color(0xfff4f5f9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                    ),
                  ),
                ),

                SizedBox(height: 15),

                /// CONFIRM PASSWORD
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Color(0xfff4f5f9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm password";
                      }
                      if (value != passwordController.text.trim()) {
                        return "Passwords don't match";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Confirm Password",
                    ),
                  ),
                ),

                SizedBox(height: 50),

                /// BUTTON
                GestureDetector(
                  onTap: isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            email = emailController.text.trim();
                            password = passwordController.text.trim();
                            confirmPassword = confirmPasswordController.text
                                .trim();

                            registration();
                          }
                        },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 129, 48, 19),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),

                SizedBox(height: 8),

                /// LOGIN LINK
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
