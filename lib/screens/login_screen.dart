import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_screen.dart';
import 'password_recovery_screen.dart';
import 'WelcomeScreen.dart';  // Ensure this is the correct import for your WelcomeScreen

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Updated to match the provided design's background color
      body: SafeArea(  // Added SafeArea to ensure the content is within the visible screen area
        child: SingleChildScrollView(  // Allows the screen to scroll when the keyboard appears
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 60), // Adjust spacing as needed
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 24.0, // Adjust the font size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40), // Space before the text fields
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Username or Email',
                  labelStyle: TextStyle(color: Colors.grey[600]), // Style to match the design
                  border: OutlineInputBorder(), // Adds a border to the TextFormField
                ),
              ),
              SizedBox(height: 20), // Space between the text fields
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.grey[600]), // Style to match the design
                  border: OutlineInputBorder(), // Adds a border to the TextFormField
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordRecoveryScreen()));
                  },
                  child: Text('Forgot Password?', style: TextStyle(color: Colors.black)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Button color
                    foregroundColor: Colors.white, // Text color
                    minimumSize: Size(double.infinity, 50) // Button size
                ),
                onPressed: () => _login(context),
                child: Text('Login'),
              ),
              SizedBox(height: 30), // Space before the bottom text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Create An Account "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red, // Adjust the color to match your theme
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigate to WelcomeScreen if login is successful
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => WelcomeScreen()));
    } on FirebaseAuthException catch (e) {
      var errorMessage = 'An error occurred. Please try again later.';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
